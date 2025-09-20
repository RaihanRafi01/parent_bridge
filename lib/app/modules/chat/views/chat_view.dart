import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../common/appColors.dart';
import '../../../../common/customFont.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildAppBar(),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: EdgeInsets.all(16.r),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return _buildChatBubble(message);
                },
              ),
            ),
          ),
          Obx(() {
            if (controller.isSuggestionBoxVisible.value) {
              return _buildSuggestionBox();
            } else {
              return const SizedBox.shrink();
            }
          }),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}

Widget _buildAppBar() {
  final ChatController controller = Get.find();
  return Container(
    padding: EdgeInsets.only(top: 50.h, left: 16.w, right: 16.w, bottom: 20.h),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFFCB93F2), Color(0xFF89C5E1)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(40.r),
        bottomRight: Radius.circular(40.r),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: Get.back,
          child: SvgPicture.asset('assets/images/common/back_icon.svg'),
        ),
        CircleAvatar(
          backgroundImage: const AssetImage("assets/images/auth/img.png"),
          radius: 28.r,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Michael",
                style: h2.copyWith(fontSize: 22.sp, color: AppColors.txtclr5),
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: const Color(0xFF14F269),
                    size: 10.r,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Online Now",
                    style: h4.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.txtclr4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => Transform.scale(
                scale: 0.6,
                child: Switch(
                  value: controller.showOriginal.value,
                  onChanged: controller.toggleShowOriginal,
                  activeColor: Colors.white,
                  activeTrackColor: AppColors.txtclr5,
                ),
              ),
            ),
            Text(
              'Show original',
              style: h2.copyWith(color: AppColors.txtclr5, fontSize: 11.sp),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildChatBubble(ChatMessage message) {
  final ChatController controller = Get.find();
  final bool isSentByMe = message.isSentByMe;

  final bubble = Container(
    constraints: BoxConstraints(maxWidth: 0.7.sw),
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: isSentByMe ? AppColors.customSkyBlue3 : AppColors.customsky,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
        bottomLeft: isSentByMe
            ? Radius.circular(20.r)
            : const Radius.circular(0),
        bottomRight: isSentByMe
            ? const Radius.circular(0)
            : Radius.circular(20.r),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (message.originalText != null && controller.showOriginal.value)
          Text(
            message.originalText!,
            style: h1.copyWith(color: AppColors.txtclr9, fontSize: 12.sp),
          ),
        if (message.originalText != null && controller.showOriginal.value)
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/images/chat/flag.svg'),
                    SizedBox(width: 8.w),
                    Text(
                      'Message Filtered',
                      style: h1.copyWith(
                        color: AppColors.txtclr9,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  message.text,
                  style: h1.copyWith(fontSize: 14.sp, color: AppColors.txtclr5),
                ),
              ],
            ),
          )
        else
          Text(
            message.text,
            style: h1.copyWith(fontSize: 14.sp, color: AppColors.txtclr5),
          ),
      ],
    ),
  );

  final messageWithTime = Column(
    crossAxisAlignment: isSentByMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
    children: [
      bubble,
      SizedBox(height: 4.h),
      Text(
        message.time,
        style: h4.copyWith(fontSize: 10.sp, color: Colors.grey),
      ),
    ],
  );

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0.h),
    child: Row(
      mainAxisAlignment: isSentByMe
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isSentByMe)
          CircleAvatar(
            backgroundImage: AssetImage(message.avatarAssetPath),
            radius: 20.r,
          ),
        if (!isSentByMe) SizedBox(width: 8.w),
        Flexible(child: messageWithTime),
        if (isSentByMe) SizedBox(width: 8.w),
        if (isSentByMe)
          CircleAvatar(
            backgroundImage: AssetImage(message.avatarAssetPath),
            radius: 20.r,
          ),
      ],
    ),
  );
}

Widget _buildSuggestionBox() {
  final ChatController controller = Get.find();
  return Container(
    padding: EdgeInsets.all(16.r),
    color: Colors.white,
    child: Column(
      children: controller.suggestions.map((suggestion) {
        return _buildSuggestionItem(suggestion);
      }).toList(),
    ),
  );
}

Widget _buildSuggestionItem(Suggestion suggestion) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.h),
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: AppColors.clrWhite,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25.r),
        topLeft: Radius.circular(25.r),
        topRight: Radius.circular(25.r),
      ),
      border: Border.all(color: AppColors.customSkyBlue3),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5.5.w, vertical: 2.2.h),
          decoration: BoxDecoration(
            color: suggestion.color,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            suggestion.title,
            style: h3.copyWith(color: AppColors.txtclr5, fontSize: 12.sp),
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          suggestion.text,
          style: h4.copyWith(fontSize: 14.sp, color: AppColors.customSkyBlue3),
        ),
      ],
    ),
  );
}

Widget _buildBottomNavigationBar(BuildContext context) {
  final ChatController controller = Get.find();
  return SafeArea(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/images/chat/camera.svg',
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 10.w),
          SvgPicture.asset(
            'assets/images/chat/doc_icon.svg',
            colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
            width: 24.w,
            height: 24.h,
          ),
          SizedBox(width: 10.w),
          InkWell(
            onTap: () => _showVoiceRecorderDialog(context),
            child: SvgPicture.asset(
              'assets/images/chat/mice.svg',
              colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
              width: 24.w,
              height: 24.h,
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: () => controller.toggleSuggestionBox(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.clrGreen4,
              ),
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5.r),
              ),

            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              style: h4.copyWith(fontSize: 14.sp),
              decoration: InputDecoration(
                fillColor: AppColors.customskyblue4,
                filled: true,
                hintText: "I Understand. Let Me...",
                hintStyle: h4.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.txtclr10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: AppColors.customSkyBlue3,
                    width: 1.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          const Icon(Icons.send, color: AppColors.customSkyBlue3),
        ],
      ),
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Voice To Text',
                    style: h2.copyWith(
                      fontSize: 16.sp,
                      color: AppColors.txtclr5,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 18.sp,
                        color: Colors.black54,
                      ),
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
                        CircleAvatar(
                          radius: 45.r,
                          backgroundColor: AppColors.txtclr12.withOpacity(0.1),
                        ),
                        CircleAvatar(
                          radius: 35.r,
                          backgroundColor: AppColors.txtclr12,
                          child: Icon(
                            Icons.mic,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.customSkyBlue3,
                        borderRadius: BorderRadius.circular(7.26.r),
                      ),
                      child: Text(
                        '00:00:00',
                        style: h2.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.blackactive,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: TextField(
                                  controller: TextEditingController(
                                    text:
                                        'Can You Pick Up Emma From School Today?\n' *
                                        2,
                                  ),
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  style: h2.copyWith(
                                    fontSize: 14.sp,
                                    color: AppColors.txtclr12,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.fromLTRB(
                                      12.w,
                                      30.h,
                                      20.w,
                                      8.h,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10.h,
                                left: 12.w,
                                child: Text(
                                  'Transcription',
                                  style: h2.copyWith(
                                    color: AppColors.txtclr11,
                                    fontSize: 12.sp,
                                  ),
                                ),
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
                    label: Text(
                      'Try Again',
                      style: h2.copyWith(fontSize: 12.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: BorderSide(color: AppColors.gray4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 8.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.customSkyBlue3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      'Use Text',
                      style: h2.copyWith(
                        color: AppColors.blackactive,
                        fontSize: 12.sp,
                      ),
                    ),
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
