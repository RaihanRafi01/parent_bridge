import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddEventView extends GetView {
  const AddEventView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddEventView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddEventView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
