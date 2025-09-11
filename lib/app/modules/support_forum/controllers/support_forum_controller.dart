import 'dart:ui';

import 'package:get/get.dart';

class SupportForumController extends GetxController {


  // list for dropdown menu .. 
  var selectedValue=RxnString();  // can start with null value ...
    final List<Map<String,dynamic>> items=[ {'name':'Scheduling', 'color':Color(0xffFFEDCA),'fcolor':Color(0xffFFAD13)},
      {'name':'Parenting', 'color':Color(0xffE4E9FA),'fcolor':Color(0xff1E40AF)},
      {'name':'Communication', 'color':Color(0xffFFE5E5),'fcolor':Color(0xffEF4444)},
      {'name':'Success story', 'color':Color(0xffDEFDDB),'fcolor':Color(0xff68B961)},
    ].obs;

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
