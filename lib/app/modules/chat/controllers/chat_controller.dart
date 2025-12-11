// chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../common/appColors.dart';

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
  var statusColor = 'green'.obs;
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
  Timer? _suggestionTimer;

  final int myUserId = 13;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    messageController = TextEditingController();
    messageController.addListener(_onTextChanged);

    print('ChatController initialized');
    connectWebSocket();
  }

  @override
  void onClose() {
    messageController.removeListener(_onTextChanged);
    messageController.dispose();
    channel.sink.close();
    scrollController.dispose();
    _typingTimer?.cancel();
    _suggestionTimer?.cancel();
    print('ChatController closed & resources cleaned');
    super.onClose();
  }

  void connectWebSocket() {
    const String url = 'ws://10.10.13.73:7000/ws/chat/ddb394f9-b32f-47ce-b8b5-e4db4e196335/?Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkxMjY0NzEwLCJpYXQiOjE3NjUzNDQ3MTAsImp0aSI6IjU3ZDg4MmQ1MTkxZjQwMDFiODg4YzExNjkwOTI1YTY4IiwidXNlcl9pZCI6IjEzIn0.Vy4euW9yvt2CDDhuzxmdRmCpYQW0F4gkeBvQp38ZaHI';

    const String url2 = 'ws://10.10.13.73:7000/ws/chat/ddb394f9-b32f-47ce-b8b5-e4db4e196335/?Authorization=Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzkxMjc3NzUzLCJpYXQiOjE3NjUzNTc3NTMsImp0aSI6IjhlMDc4OTAxNjI3MzQ4M2RhNTEzMGRiNjc3NTY1MTcxIiwidXNlcl9pZCI6IjI1In0.4SGie1YrEHUYBhT7qfGu7uJQlFKfGUlIhW2miz7GV9s';


    print('🧩🧩🧩🧩🧩Connecting to WebSocket...');

    channel = WebSocketChannel.connect(Uri.parse(url));
    channel2 = WebSocketChannel.connect(Uri.parse(url2));

    channel.ready.then((_) {
      print('🏀🏀🏀WebSocket Connected Successfully!');
    }).catchError((e) {
      print('🏀🏀🏀WebSocket Connection Failed: $e');
    });
    channel2.ready.then((_) {
      print('🥎🥎🥎WebSocket 2 Connected Successfully!');
    }).catchError((e) {
      print('🥎🥎🥎WebSocket 2 Connection Failed: $e');
    });

    channel.stream.listen(
          (rawMessage) {
        final data = jsonDecode(rawMessage as String);
        final type = data['type'];

        print('🧩🧩🧩🧩🧩\nReceived ← $type');
        print('🧩🧩🧩🧩🧩Payload: ${jsonEncode(data)}');

        switch (type) {
          case 'chat_message':
            _handleIncomingMessage(data);
            break;

          case 'typing':
            final userId = data['user_id'];
            final typing = data['is_typing'] == true;
            if (userId != myUserId) {
              isOtherTyping.value = typing;
              print(typing ? '$userId is typing...' : '$userId stopped typing');
            }
            break;

          case 'suggestion_response':
            _handleSuggestionResponse(data);
            break;

          default:
            print('🧩🧩🧩🧩🧩Unknown message type: $type');
        }
      },
      onError: (error) {
        print('🧩🧩🧩🧩🧩WebSocket Error: $error');
      },
      onDone: () {
        print('🧩🧩🧩🧩🧩WebSocket Connection Closed');
      },
    );
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    final senderId = data['sender_id'];
    final isMe = senderId == myUserId;

    print(isMe ? '🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩You sent a message' : 'Message from $senderId');

    final originalText = data['is_filtered'] == true ? data['message'] : null;
    final displayText = data['is_filtered'] == true ? data['filtered_message'] : data['message'];

    if (originalText != null) {
      print('🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩Message was filtered!');
      print('Original: $originalText');
      print('Filtered: $displayText');
    }

    messages.add(ChatMessage(
      text: displayText,
      originalText: originalText,
      time: _formatTime(data['timestamp']),
      isSentByMe: isMe,
      avatarAssetPath: isMe ? "assets/images/chat/user_2.png" : "assets/images/auth/img.png",
    ));

    print('Total messages: ${messages.length}');
    scrollToBottom();
  }

  void _handleSuggestionResponse(Map<String, dynamic> data) {
    final color = (data['status_color'] ?? 'green').toString().toLowerCase();
    statusColor.value = color;

    print('🧩🧩🧩🧩🧩AI Tone Detected → $color'.toUpperCase());

    final List<dynamic> suggestionList = data['suggestion'] ?? [];
    print('🧩🧩🧩🧩🧩AI Suggestions Received (${suggestionList.length})');

    final List<Suggestion> parsed = suggestionList.map((item) {
      final tone = (item['tone'] ?? 'neutral').toString().toLowerCase();
      final text = item['suggestion'] ?? '';

      late Color bgColor;
      late String title;

      if (tone.contains('supportive')) {
        bgColor = AppColors.customyellow;
        title = 'Supportive';
      } else if (tone.contains('cooperative')) {
        bgColor = AppColors.lightPurplePink2;
        title = 'Cooperative';
      } else {
        bgColor = AppColors.customSkyBlue3;
        title = 'Neutral';
      }

      print('→ $title: "$text"');

      return Suggestion(title: title, text: text, color: bgColor);
    }).toList();

    liveSuggestions.assignAll(parsed);
    print('🧩🧩🧩🧩🧩Live suggestions updated!🧩🧩🧩🧩🧩');
  }

  void _onTextChanged() {
    final text = messageController.text.trim();
    final words = text.split(RegExp(r'\s+'));

    // Typing indicator
    if (text.isNotEmpty) {
      if (!isTyping) {
        print('You started typing...');
        _sendTyping(true);
        isTyping = true;
      }
      _typingTimer?.cancel();
      _typingTimer = Timer(const Duration(seconds: 2), () {
        print('Typing stopped');
        _sendTyping(false);
        isTyping = false;
      });
    } else {
      if (isTyping) {
        print('Input cleared → stopped typing');
        _sendTyping(false);
        isTyping = false;
      }
      liveSuggestions.clear();
      statusColor.value = 'green';
    }

    // Auto suggestion request
    if (words.length >= 2 && text.isNotEmpty) {
      _suggestionTimer?.cancel();
      _suggestionTimer = Timer(const Duration(milliseconds: 600), () {
        print('🧩🧩🧩🧩🧩Requesting AI suggestions for: "$text"');
        channel.sink.add(jsonEncode({
          "type": "suggestion_request",
          "message": text,
        }));
      });
    } else if (words.length < 2) {
      liveSuggestions.clear();
      print('Less than 2 words → suggestions hidden');
    }
  }

  void _sendTyping(bool typing) {
    final payload = {"type": "typing", "is_typing": typing};
    channel.sink.add(jsonEncode(payload));
    print(typing ? 'Sent typing start' : 'Sent typing stop');
  }

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) {
      print('Empty message → blocked');
      return;
    }

    final isGreen = statusColor.value == 'green';
    final type = isGreen ? "message" : "filter_request";

    print('\n🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩🧩Sending $type → "$text"');

    channel.sink.add(jsonEncode({
      "type": type,
      "message": text,
      "message_type": "text",
      "reply_to": null,
      "attachment": null,
    }));

    print(isGreen
        ? 'Sent as normal message (safe tone)'
        : 'Sent to filter first (needs review)');

    // Reset UI
    messageController.clear();
    liveSuggestions.clear();
    statusColor.value = 'green';

    if (isTyping) {
      _sendTyping(false);
      isTyping = false;
    }

    print('Message sent & input cleared\n');
  }

  void applySuggestion(String suggestionText) {
    messageController.text = suggestionText;
    messageController.selection = TextSelection.fromPosition(
      TextPosition(offset: suggestionText.length),
    );
    liveSuggestions.clear();
    print('Suggestion applied: "$suggestionText"');
  }

  void toggleSuggestionBox() {
    if (liveSuggestions.isEmpty && messageController.text.isNotEmpty) {
      liveSuggestions.assignAll(fallbackSuggestions);
      print('Showing fallback suggestions');
    } else {
      liveSuggestions.clear();
      print('Suggestions hidden');
    }
  }

  void toggleShowOriginal(bool value) {
    showOriginal.value = value;
    print(value ? 'Showing original messages' : 'Hiding original messages');
  }

  String _formatTime(String timestamp) {
    try {
      return DateFormat('hh:mm a').format(DateTime.parse(timestamp).toLocal());
    } catch (e) {
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