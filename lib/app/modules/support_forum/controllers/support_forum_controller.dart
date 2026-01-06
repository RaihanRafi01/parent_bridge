import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parent_bridge/app/core/constants/api.dart';
import 'package:parent_bridge/app/core/services/base_client.dart';
import 'package:parent_bridge/common/appColors.dart';

class SupportForumController extends GetxController {
  // list for dropdown menu ..
  var selectedValue = RxnString(); // can start with null value ...
  final List<Map<String, dynamic>> items = [
    {
      'name': 'Scheduling',
      'color': AppColors.controler_list_color_00,
      'fcolor': AppColors.controler_list_color_01,
    },
    {
      'name': 'Parenting',
      'color': AppColors.controler_list_color_10,
      'fcolor': AppColors.controler_list_color_11,
    },
    {
      'name': 'Communication',
      'color': AppColors.controler_list_color_20,
      'fcolor': AppColors.controler_list_color_21,
    },
    {
      'name': 'Success story',
      'color': AppColors.controler_list_color_30,
      'fcolor': AppColors.controler_list_color_31,
    },
  ].obs;

  void setSelected(String value) {
    selectedValue.value = value;
    selectedCategory.value = value; // Update the selectedCategory
  }

  // This is for the select category part.
  var selectedCategory = Rxn<String>();
  var isLoading = false.obs;
  var isCommentsLoading = false.obs;
  var isReplying = false.obs;
  var posts = <dynamic>[].obs;
  var comments = <dynamic>[].obs;

  // Search
  var searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  final TextEditingController commentController = TextEditingController();

  void setSearchQuery(String q) {
    searchQuery.value = q;
  }

  @override
  void onInit() {
    super.onInit();
    fetchPosts();

    // Debounce search input to avoid too many rebuilds when typing
    debounce(searchQuery, (String? val) {}, time: Duration(milliseconds: 300));
  }

  @override
  void onClose() {
    searchController.dispose();
    commentController.dispose();
    super.onClose();
  }

  Future<void> fetchComments(int postId) async {
    try {
      isCommentsLoading.value = true;
      comments.clear();
      debugPrint(
        "DEBUG: fetchComments() -> postId: $postId, api: ${Api.getComments(postId)}",
      );
      final response = await BaseClient.getRequest(
        api: Api.getComments(postId),
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: fetchComments() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        comments.value = data['data'] ?? [];
      } else {
        debugPrint(
          "DEBUG: fetchComments() non-200 status: ${response.statusCode}",
        );
      }
    } catch (e, st) {
      debugPrint("Error fetching comments: $e");
      debugPrintStack(stackTrace: st);
    } finally {
      isCommentsLoading.value = false;
    }
  }

  Future<void> postComment(int postId, String content) async {
    if (content.trim().isEmpty) return;

    try {
      final requestBody = jsonEncode({"message": content});
      debugPrint(
        "DEBUG: postComment() -> postId: $postId, api: ${Api.createComment(postId)}, body: $requestBody",
      );

      final response = await BaseClient.postRequest(
        api: Api.createComment(postId),
        body: requestBody,
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: postComment() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Refresh comments after posting
        await fetchComments(postId);
        // Also refresh posts to update comment count
        await fetchPosts();
      } else {
        Get.snackbar(
          "Error",
          "Failed to post comment",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, st) {
      debugPrint("Error posting comment: $e");
      debugPrintStack(stackTrace: st);
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<bool> postReply(int postId, int commentId, String content) async {
    if (content.trim().isEmpty) return false;

    try {
      isReplying.value = true;
      // Use the same create comment endpoint but include reply_to to link the reply
      final requestBody = jsonEncode({
        "message": content,
        "reply_to": commentId,
      });
      debugPrint(
        "DEBUG: postReply() -> postId: $postId, commentId: $commentId, api: ${Api.createComment(postId)}, body: $requestBody",
      );

      final response = await BaseClient.postRequest(
        api: Api.createComment(postId),
        body: requestBody,
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: postReply() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Refresh comments to show the new reply
        await fetchComments(postId);
        // Optionally refresh posts if you rely on counts
        await fetchPosts();
        Get.snackbar(
          "Success",
          "Reply posted successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      } else {
        debugPrint(
          'DEBUG: postReply() failed -> status=${response.statusCode}',
        );
        Get.snackbar(
          "Error",
          "Failed to post reply",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e, st) {
      debugPrint("Error posting reply: $e");
      debugPrintStack(stackTrace: st);
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isReplying.value = false;
    }
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      debugPrint("DEBUG: fetchPosts() -> api: ${Api.getPosts}");
      final response = await BaseClient.getRequest(
        api: Api.getPosts,
        headers: BaseClient.authHeaders(),
      );

      debugPrint(
        "DEBUG: fetchPosts() response -> status=${response.statusCode}, body=${response.body}",
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        posts.value = data['data'] ?? [];
      } else {
        Get.snackbar(
          "Error",
          "Failed to fetch posts",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e, st) {
      debugPrint("Error fetching posts: $e");
      debugPrintStack(stackTrace: st);
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Color getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'scheduling':
        return AppColors.anonymous_parent_01;
      case 'parenting':
        return AppColors.controler_list_color_11;
      case 'communication':
        return AppColors.anonymous_parent_07;
      case 'success':
        return AppColors.anonymous_parent_05;
      default:
        return AppColors.anonymous_parent_01;
    }
  }

  Color getCategoryBgColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'scheduling':
        return AppColors.anonymous_parent_02;
      case 'parenting':
        return AppColors.anonymous_parent_04;
      case 'communication':
        return AppColors.anonymous_parent_08;
      case 'success':
        return AppColors.anonymous_parent_06;
      default:
        return AppColors.anonymous_parent_02;
    }
  }

  Future<void> toggleReaction(int postId) async {
    try {
      final body = {"reaction_type": "like"};

      final response = await BaseClient.postRequest(
        api: Api.toggleReaction(postId),
        body: jsonEncode(body),
        headers: BaseClient.authHeaders(),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Refresh posts to get updated counts
        await fetchPosts();
        Get.snackbar(
          "Success",
          data['message'] ?? "Reaction updated",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 1),
        );
      }
    } catch (e) {
      print("Error toggling reaction: $e");
    }
  }

  var oldPosts = [
    {
      'sche_title': 'Scheduling',
      'color': AppColors.anonymous_parent_01,
      'bg_color': AppColors.anonymous_parent_02,
      'body_title': 'How do you handle holiday scheduling conflicts?',
      'body_subtitle':
          'One of the most difficult aspects of co-parenting has been dealing with last-minute changes made by my co-parent.'
          ' While occasional flexibility ',
      'dialog_subtitle':
          'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had',
    },
    {
      'sche_title': 'Parenting',
      'color': AppColors.controler_list_color_11,
      'bg_color': AppColors.anonymous_parent_04,
      'body_title': 'Dealing with different parenting styles',
      'body_subtitle':
          'One ongoing challenge is that my co-parent frequently changes plans at the last minute,This is ready to go ',
      'dialog_subtitle':
          'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had',
    },
    {
      'sche_title': 'Success story',
      'color': AppColors.anonymous_parent_05,
      'bg_color': AppColors.anonymous_parent_06,
      'body_title': 'Success story ,Communication improvement',
      'body_subtitle':
          'One of our biggest successes as co-parents has been improving our communication.'
          ' In the beginning, we often misunderstood each other .',
      'dialog_subtitle':
          'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had',
    },
    {
      'sche_title': 'Communication',
      'color': AppColors.anonymous_parent_07,
      'bg_color': AppColors.anonymous_parent_08,
      'body_title': 'Success story ,Communication improvement',
      'body_subtitle':
          'One of our biggest successes as co-parents has been improving our communication.'
          ' In the beginning, we often misunderstood each other .',
      'dialog_subtitle':
          'One of the most difficult aspects of co-parenting has been dealing with last-minute '
          'changes made by my co-parent. While occasional flexibility is understandable and sometimes necessary, '
          'the frequent and unpredictable nature of these changes creates ongoing challenges.'
          ' It disrupts not only my personal and professional schedule but, more importantly,'
          ' the emotional and mental stability of our children. Children thrive on routine, '
          'predictability, and consistency. When plans are constantly changed at the eleventh hour—without adequate notice or'
          ' discussion—it creates confusion, disappointment, and anxiety for them. They often look forward to certain activities or time with each parent,'
          ' and when those expectations aren’t met due to sudden changes, it can erode their sense of trust and emotional security'
          ' As a co-parent, I strongly believe that communication and mutual respect are the cornerstones of a'
          'successful co-parenting relationship. When one parent consistently alters arrangements without considering '
          'the impact on the other parent or the children, it sets a harmful precedent. It sends the message that one'
          ' parent’s time and emotional input are less valuable, which is neither fair nor sustainable. This kind of'
          'behavior forces the other parent to scramble, reschedule'
          'and manage the children’s reactions—all of which can be emotionally draining. In many cases, I’ve had',
    },
  ];

  //TODO: Implement SupportForumController

  final count = 0.obs;

  void increment() => count.value++;
}
