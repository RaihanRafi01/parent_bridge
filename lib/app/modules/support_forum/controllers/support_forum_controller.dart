import 'package:get/get.dart';

class SupportForumController extends GetxController {


  // list for dropdown menu .. 
  var selectedValue='Scheduling'.obs;
    final items=['Scheduling','Parenting','Communication','Success Story'].obs;

  void setSelected(String value){
    selectedValue.value=value;
  }





  //TODO: Implement SupportForumController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
