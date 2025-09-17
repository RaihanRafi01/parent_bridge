import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  var isSuggestionBoxVisible = false.obs;

  var messages = <ChatMessage>[].obs;
  final List<Suggestion> suggestions = [
    Suggestion(
        title: 'Neutral',
        text: 'I understand. Let me check my schedule and get back to you.',
        color: AppColors.customSkyBlue3),
    Suggestion(
        title: 'Cooperative',
        text:
        'That sounds reasonable. I appreciate your letting me know in advance.',
        color: AppColors.lightPurplePink2),
    Suggestion(
        title: 'Supportive',
        text:
        'Thank you for communicating about this. Let\'s work together to find the best solution.',
        color: AppColors.customyellow),
  ];

  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    _loadDummyMessages();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _loadDummyMessages() {
    messages.assignAll([
      ChatMessage(
        originalText:
        'You always mess up the pickup time! can we actually discuss this properly for once?',
        text: 'Can we discuss the pickup time for saturday?',
        time: '10:30 am',
        isSentByMe: false,
        avatarAssetPath: "assets/images/auth/img.png",
      ),
      ChatMessage(
        text: 'Sure, what time works best for you?',
        time: '10:30 am',
        isSentByMe: true,
        avatarAssetPath: "assets/images/auth/img.png",
      ),
      ChatMessage(
        text: 'I need to pick up emma at 3 pm instead of 2 pm due to work.',
        time: '10:30 am',
        isSentByMe: false,
        avatarAssetPath: "assets/images/auth/img.png",
      ),
      ChatMessage(
        originalText:
        'Fine, whatever works for you. I guess I\'ll have emma ready whenever you decide to show up.',
        text: 'Yes, that will work. \n I\'ll have her ready.',
        time: '10:30 am',
        isSentByMe: true,
        avatarAssetPath: "assets/images/auth/img.png",
      ),
    ]);
  }

  void toggleShowOriginal(bool value) {
    showOriginal.value = value;
  }

  void toggleSuggestionBox() {
    isSuggestionBoxVisible.value = !isSuggestionBoxVisible.value;
  }
}