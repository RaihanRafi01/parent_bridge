import 'package:get/get.dart';

import '../controllers/support_forum_controller.dart';

class SupportForumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportForumController>(
      () => SupportForumController(),
    );
  }
}
