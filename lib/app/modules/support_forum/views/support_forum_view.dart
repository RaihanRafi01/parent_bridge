import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/support_forum_controller.dart';

class SupportForumView extends GetView<SupportForumController> {
  const SupportForumView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SupportForumView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SupportForumView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
