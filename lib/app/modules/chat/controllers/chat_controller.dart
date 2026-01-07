import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../common/app_colors.dart';

class ChatMessage {
  final String text;
  final String? originalText;
  final String time;
  final bool isSentByMe;
  final String avatarAssetPath;

  ChatMessage({
    required this.text,
    this.originalText,
    required this.time,
    required this.isSentByMe,
    required this.avatarAssetPath,
  });
}

class Suggestion {
  final String title;
  final String text;
  final Color color;

  Suggestion({required this.title, required this.text, required this.color});
}

class ChatController extends GetxController {
  var showOriginal = true.obs;
  var isOtherTyping = false.obs;
  var liveSuggestions = <Suggestion>[].obs;
  var statusColor = 'grey'.obs;
  var isSending = false.obs;

  // Tracks if current text came from tapping a suggestion (and hasn't been edited yet)
  var isFromUntouchedSuggestion = false.obs;

  // NEW: Track if we are currently waiting for a suggestion response
  var isWaitingForSuggestion = false.obs;

  var messages = <ChatMessage>[].obs;

  final List<Suggestion> fallbackSuggestions = [
    Suggestion(title: 'Neutral', text: 'I understand. Let me check my schedule.', color: AppColors.customSkyBlue3),
    Suggestion(title: 'Cooperative', text: 'That sounds reasonable. Thanks!', color: AppColors.lightPurplePink2),
    Suggestion(title: 'Supportive', text: 'Let\'s work together on this.', color: AppColors.customyellow),
  ];

  late ScrollController scrollController;
  late TextEditingController messageController;
  late WebSocketChannel channel;
  late WebSocketChannel channel2;

  bool isTyping = false;
  Timer? _typingTimer;
  Timer? _suggestionDebounceTimer;

  final int myUserId = 13;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    messageController = TextEditingController();
    messageController.addListener(_onTextChanged);
    connectWebSocket();
  }

  @override
  void onClose() {
    messageController.removeListener(_onTextChanged);
    messageController.dispose();
    scrollController.dispose();
    channel.sink.close();
    _typingTimer?.cancel();
    _suggestionDebounceTimer?.cancel();
    super.onClose();
  }

  void connectWebSocket() {
    const String url = 'ws://10.10.13.73:7000/ws/chat/ddb394f9-b32f-47ce-b8b5-e4db4e196335/?Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkxMjY0NzEwLCJpYXQiOjE3NjUzNDQ3MTAsImp0aSI6IjU3ZDg4MmQ1MTkxZjQwMDFiODg4YzExNjkwOTI1YTY4IiwidXNlcl9pZCI6IjEzIn0.Vy4euW9yvt2CDDhuzxmdRmCpYQW0F4gkeBvQp38ZaHI';
    const String url2 = 'ws://10.10.13.73:7000/ws/chat/ddb394f9-b32f-47ce-b8b5-e4db4e196335/?Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkxMjc3NzUzLCJpYXQiOjE3NjUzNTc3NTMsImp0aSI6IjhlMDc4OTAxNjI3MzQ4M2RhNTEzMGRiNjc3NTY1MTcxIiwidXNlcl9pZCI6IjI1In0.4SGie1YrEHUYBhT7qfGu7uJQlFKfGUlIhW2miz7GV9s';

   debugPrint('Connecting to WebSocket...');

    channel = WebSocketChannel.connect(Uri.parse(url));
    channel2 = WebSocketChannel.connect(Uri.parse(url2));

    channel.ready.then((_) =>debugPrint('WebSocket Connected'));

    channel.stream.listen(
          (rawMessage) {
       debugPrint('Received: $rawMessage');
        final data = jsonDecode(rawMessage as String);
        final type = data['type'];

        switch (type) {
          case 'chat_message':
            _handleIncomingMessage(data);
            break;
          case 'typing':
            final userId = data['user_id'];
            if (userId != myUserId) {
              isOtherTyping.value = data['is_typing'] == true;
            }
            break;
          case 'suggestion_response':
            if (isSending.value) return;
            _handleSuggestionResponse(data);
            break;
        }
      },
      onError: (e) =>debugPrint('WS Error: $e'),
    );
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    final isMe = data['sender_id'] == myUserId;
    final originalText = data['is_filtered'] == true ? data['message'] : null;
    final displayText = data['is_filtered'] == true ? data['filtered_message'] : data['message'];

    messages.add(ChatMessage(
      text: displayText,
      originalText: originalText,
      time: _formatTime(data['timestamp']),
      isSentByMe: isMe,
      avatarAssetPath: isMe ? "assets/images/chat/user_2.png" : "assets/images/auth/img.png",
    ));

    scrollToBottom();
  }

  void _handleSuggestionResponse(Map<String, dynamic> data) {
    final currentText = messageController.text.trim();
    final originalMessage = (data['original_message'] ?? '').toString().trim();

    // Ignore if this response is for old text
    if (currentText.isEmpty || originalMessage != currentText) {
     debugPrint('Ignoring outdated suggestion response: "$originalMessage" (current: "$currentText")');
      return;
    }

    // We got a valid response → stop waiting
    isWaitingForSuggestion.value = false;

    final color = (data['status_color'] ?? 'grey').toString().toLowerCase();

    if (!isFromUntouchedSuggestion.value) {
      statusColor.value = color;
    }

    final List<dynamic> rawList = data['suggestion'] ?? [];

    if (rawList.isNotEmpty) {
      final parsed = rawList.map((item) {
        final tone = (item['tone'] ?? 'neutral').toString().toLowerCase();
        final text = (item['suggestion'] ?? '').toString().trim();

        late Color bg;
        late String title;

        if (tone.contains('supportive')) {
          bg = AppColors.customyellow;
          title = 'Supportive';
        } else if (tone.contains('cooperative')) {
          bg = AppColors.lightPurplePink2;
          title = 'Cooperative';
        } else {
          bg = AppColors.customSkyBlue3;
          title = 'Neutral';
        }

        return Suggestion(title: title, text: text, color: bg);
      }).toList();

      liveSuggestions.assignAll(parsed);
    } else {
      liveSuggestions.clear(); // null suggestions → hide
    }
  }

  void _onTextChanged() {
    final text = messageController.text.trim();
    final words = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;

    if (isSending.value) return;

    if (text.isEmpty) {
      statusColor.value = 'grey';
      isFromUntouchedSuggestion.value = false;
      isWaitingForSuggestion.value = false;
      liveSuggestions.clear();
      _suggestionDebounceTimer?.cancel();
      if (isTyping) _sendTyping(false);
      return;
    }

    statusColor.value = 'grey';

    // User edited a selected suggestion → reset
    if (isFromUntouchedSuggestion.value) {
      isFromUntouchedSuggestion.value = false;
    }

    if (!isTyping) {
      _sendTyping(true);
      isTyping = true;
    }
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 3), () => _sendTyping(false));

    // Only trigger suggestion request if ≥2 words and not from untouched suggestion
    if (words >= 2 && !isFromUntouchedSuggestion.value) {
      // Cancel previous debounce
      _suggestionDebounceTimer?.cancel();

      // Mark that we are now waiting
      isWaitingForSuggestion.value = true;
      liveSuggestions.clear(); // Clear old suggestions immediately

      _suggestionDebounceTimer = Timer(const Duration(seconds: 3), () {
        if (isSending.value) return;

        final currentText = messageController.text.trim();
        if (currentText.isEmpty || currentText.split(RegExp(r'\s+')).length < 2) {
          isWaitingForSuggestion.value = false;
          return;
        }

        final jsonStr = jsonEncode({"type": "suggestion_request", "message": currentText});
       debugPrint('Sending ------->: $jsonStr');
        channel.sink.add(jsonStr);
      });
    } else {
      isWaitingForSuggestion.value = false;
      liveSuggestions.clear();
    }
  }

  void _sendTyping(bool typing) {
    isTyping = typing;
    final jsonStr = jsonEncode({"type": "typing", "is_typing": typing});
   debugPrint('Sending ------->: $jsonStr');
    channel.sink.add(jsonStr);
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    isSending.value = true;

    final bool isGreen = statusColor.value == 'green';
    final String type = isGreen ? "message" : "filter_request";

    final jsonStr = jsonEncode({
      "type": type,
      "message": text,
      "message_type": "text",
      "reply_to": null,
      "attachment": null,
    });
   debugPrint('Sending ------->: $jsonStr');
    channel.sink.add(jsonStr);

    messageController.clear();
    liveSuggestions.clear();
    statusColor.value = 'grey';
    isFromUntouchedSuggestion.value = false;
    isWaitingForSuggestion.value = false;
    _suggestionDebounceTimer?.cancel();
    if (isTyping) _sendTyping(false);

    isSending.value = false;
  }

  void applySuggestion(String suggestionText) {
    if (isSending.value) return;

    messageController.text = suggestionText;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: suggestionText.length),
    );

    isFromUntouchedSuggestion.value = true;
    statusColor.value = 'green';
    liveSuggestions.clear();
    isWaitingForSuggestion.value = false;
    _suggestionDebounceTimer?.cancel();
  }

  void toggleSuggestionBox() {
    if (isSending.value || messageController.text.trim().isEmpty) {
      liveSuggestions.clear();
      return;
    }
    if (liveSuggestions.isEmpty) {
      liveSuggestions.assignAll(fallbackSuggestions);
    } else {
      liveSuggestions.clear();
    }
  }

  void toggleShowOriginal(bool v) => showOriginal.value = v;

  String _formatTime(String ts) {
    try {
      return DateFormat('hh:mm a').format(DateTime.parse(ts).toLocal());
    } catch (_) {
      return 'Now';
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}