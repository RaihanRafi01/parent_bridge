import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: Stack(
              children: [
                // MAIN CHAT LIST
                Obx(() {
                  controller.messages.length;
                  controller.showOriginal.value;
                  controller.isOtherTyping.value;

                  return ListView.builder(
                    controller: controller.scrollController,
                    padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 120.r),
                    itemCount: controller.messages.length + (controller.isOtherTyping.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < controller.messages.length) {
                        return _buildChatBubble(controller.messages[index]);
                      } else {
                        return _buildTypingIndicator();
                      }
                    },
                  );
                }),

                // LIVE SUGGESTIONS — FLOATING ABOVE INPUT
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _buildLiveSuggestions(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // ==================== APP BAR ====================
  Widget _buildAppBar() {
    return Container(
      padding: EdgeInsets.only(top: 50.h, left: 16.w, right: 16.w, bottom: 20.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40.r), bottomRight: Radius.circular(40.r)),
      ),
      child: Row(
        children: [
          GestureDetector(onTap: Get.back, child: SvgPicture.asset('assets/images/common/back_icon.svg')),
          SizedBox(width: 12.w),
          CircleAvatar(backgroundImage: const AssetImage("assets/images/auth/img.png"), radius: 28.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Michael", style: h2.copyWith(fontSize: 22.sp, color: AppColors.txtclr5)),
                Row(children: [
                  Icon(Icons.circle, color: const Color(0xFF14F269), size: 10.r),
                  SizedBox(width: 5.w),
                  Text("Online Now", style: h4.copyWith(fontSize: 12.sp, color: AppColors.txtclr4)),
                ]),
              ],
            ),
          ),
          Column(children: [
            Obx(() => Transform.scale(
              scale: 0.6,
              child: Switch(
                value: controller.showOriginal.value,
                onChanged: controller.toggleShowOriginal,
                activeColor: Colors.white,
                inactiveThumbColor: AppColors.txtclr5,
                activeTrackColor: AppColors.txtclr5,
              ),
            )),
            Text('Show original', style: h2.copyWith(color: AppColors.txtclr5, fontSize: 11.sp)),
          ]),
        ],
      ),
    );
  }

  // ==================== CHAT BUBBLE ====================
  Widget _buildChatBubble(ChatMessage message) {
    final isMe = message.isSentByMe;
    final ctrl = Get.find<ChatController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) CircleAvatar(backgroundImage: AssetImage(message.avatarAssetPath), radius: 20.r),
          if (!isMe) SizedBox(width: 8.w),
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 0.7.sw),
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.customSkyBlue3 : AppColors.customsky,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: isMe ? Radius.circular(20.r) : Radius.circular(0),
                      bottomRight: isMe ? Radius.circular(0) : Radius.circular(20.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.originalText != null && ctrl.showOriginal.value) ...[
                        Text(message.originalText!, style: TextStyle(color: AppColors.txtclr9, fontSize: 12.sp)),
                        Container(
                          margin: EdgeInsets.only(top: 8.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey.shade300)),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Row(children: [
                              SvgPicture.asset('assets/images/chat/flag.svg'),
                              SizedBox(width: 8.w),
                              Text('Message Filtered', style: TextStyle(color: AppColors.txtclr9, fontSize: 11.sp))
                            ]),
                            SizedBox(height: 6.h),
                            Text(message.text, style: TextStyle(color: AppColors.txtclr5, fontSize: 14.sp)),
                          ]),
                        ),
                      ] else
                        Text(message.text, style: TextStyle(color: AppColors.txtclr5, fontSize: 15.sp)),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(message.time, style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              ],
            ),
          ),
          if (isMe) SizedBox(width: 8.w),
          if (isMe) CircleAvatar(backgroundImage: AssetImage(message.avatarAssetPath), radius: 20.r),
        ],
      ),
    );
  }

  // ==================== TYPING INDICATOR ====================
  Widget _buildTypingIndicator() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
      child: Row(children: [
        CircleAvatar(backgroundImage: const AssetImage("assets/images/auth/img.png"), radius: 20.r),
        SizedBox(width: 10.w),
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(color: AppColors.customsky, borderRadius: BorderRadius.circular(20.r)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [Dot(), Dot(delay: 0.2), Dot(delay: 0.4)]),
        ),
      ]),
    );
  }

  // ==================== LIVE SUGGESTIONS (FULLY REACTIVE) ====================
  Widget _buildLiveSuggestions() {
    return Obx(() {
      if (controller.isSending.value || controller.messageController.text.trim().isEmpty) {
        return const SizedBox.shrink();
      }

      final text = controller.messageController.text.trim();
      final words = text.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
      final waitingForAI = words >= 2 && controller.liveSuggestions.isEmpty;

      if (waitingForAI) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.r),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade200,
            highlightColor: Colors.grey.shade100,
            period: const Duration(milliseconds: 1200),
            child: Column(
              children: List.generate(2, (_) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                height: 80.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
              )),
            ),
          ),
        );
      }

      if (controller.liveSuggestions.isNotEmpty) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(16.r, 16.r, 16.r, 8.r),
          child: Column(
            children: controller.liveSuggestions.map((suggestion) {
              return GestureDetector(
                onTap: () => controller.applySuggestion(suggestion.text),
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 12.h),
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(color: AppColors.customSkyBlue3, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: Offset(0, -4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(color: suggestion.color, borderRadius: BorderRadius.circular(12.r)),
                        child: Text(suggestion.title, style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 10.h),
                      Text(suggestion.text, style: TextStyle(fontSize: 15.sp, color: AppColors.customSkyBlue3, height: 1.3)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }

  // ==================== BOTTOM BAR ====================
  Widget _buildBottomNavigationBar(BuildContext context) {
    final Map<String, Color> colorMap = {
      'green': AppColors.clrGreen4,
      'yellow': AppColors.customyellow,
      'red': Colors.red.shade400,
      'orange': Colors.orange.shade600,
      'blue': AppColors.customSkyBlue3,
      'purple': AppColors.lightPurplePink2,
      'grey': Colors.grey.shade400,
    };

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)]),
        child: Row(children: [
          SvgPicture.asset('assets/images/chat/camera.svg', width: 24.w, colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn)),
          SizedBox(width: 12.w),
          SvgPicture.asset('assets/images/chat/doc_icon.svg', width: 24.w, colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn)),
          SizedBox(width: 12.w),
          InkWell(onTap: () => _showVoiceRecorderDialog(context), child: SvgPicture.asset('assets/images/chat/mice.svg', width: 24.w, colorFilter: ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn))),
          SizedBox(width: 16.w),
          Obx(() => InkWell(
            onTap: controller.toggleSuggestionBox,
            child: Container(
              width: 26.w,
              height: 26.h,
              decoration: BoxDecoration(
                color: colorMap[controller.statusColor.value] ?? Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          )),
          SizedBox(width: 16.w),
          Expanded(
            child: TextField(
              controller: controller.messageController,
              style: TextStyle(fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: "I Understand. Let Me...",
                hintStyle: TextStyle(color: AppColors.txtclr10, fontSize: 14.sp),
                filled: true,
                fillColor: AppColors.customskyblue4,
                contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide(color: AppColors.customSkyBlue3, width: 1.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: BorderSide(color: AppColors.customSkyBlue3, width: 1.8),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          InkWell(onTap: controller.sendMessage, child: Icon(Icons.send_rounded, color: AppColors.customSkyBlue3, size: 28.r)),
        ]),
      ),
    );
  }

  void _showVoiceRecorderDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.alertbackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        content: SizedBox(
          height: 420.h,
          width: double.maxFinite,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20.w, 15.h, 15.w, 15.h),
                decoration: BoxDecoration(
                  color: AppColors.lightPurplePink2,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Voice To Text', style: h2.copyWith(fontSize: 16.sp, color: AppColors.txtclr5)),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                        child: Icon(Icons.close, size: 18.sp, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(radius: 45.r, backgroundColor: AppColors.txtclr12.withOpacity(0.1)),
                          CircleAvatar(
                            radius: 35.r,
                            backgroundColor: AppColors.txtclr12,
                            child: Icon(Icons.mic, color: Colors.white, size: 30.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(color: AppColors.customSkyBlue3, borderRadius: BorderRadius.circular(7.26.r)),
                        child: Text('00:00:00', style: h2.copyWith(fontSize: 20.sp, color: AppColors.blackactive)),
                      ),
                      SizedBox(height: 20.h),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: TextField(
                                    controller: TextEditingController(text: 'Can You Pick Up Emma From School Today?\n' * 2),
                                    maxLines: null,
                                    expands: true,
                                    keyboardType: TextInputType.multiline,
                                    style: h2.copyWith(fontSize: 14.sp, color: AppColors.txtclr12),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.fromLTRB(12.w, 30.h, 20.w, 8.h),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10.h,
                                  left: 12.w,
                                  child: Text('Transcription', style: h2.copyWith(color: AppColors.txtclr11, fontSize: 12.sp)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/images/chat/refresh.svg'),
                      label: Text('Try Again', style: h2.copyWith(fontSize: 12.sp)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        side: BorderSide(color: AppColors.gray4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/images/chat/pause.svg'),
                      label: Text('Pause', style: h2.copyWith(fontSize: 12.sp)),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        side: BorderSide(color: AppColors.gray4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.customSkyBlue3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
                      ),
                      child: Text('Use Text', style: h2.copyWith(color: AppColors.blackactive, fontSize: 12.sp)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dot extends StatefulWidget {
  final double delay;
  const Dot({super.key, this.delay = 0});

  @override
  State<Dot> createState() => _DotState();
}

class _DotState extends State<Dot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..repeat(reverse: true);
    Future.delayed(Duration(milliseconds: (widget.delay * 1000).toInt()), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.7, end: 1.3).animate(_controller),
      child: Container(
        width: 9.r,
        height: 9.r,
        margin: EdgeInsets.symmetric(horizontal: 3.r),
        decoration: BoxDecoration(color: Colors.grey.shade600, shape: BoxShape.circle),
      ),
    );
  }
}