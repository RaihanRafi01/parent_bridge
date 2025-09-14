

import 'package:get/get.dart';
import 'package:parent_bridge/common/appColors.dart';

class SupportForumController extends GetxController {


  // list for dropdown menu .. 
  var selectedValue=RxnString();  // can start with null value ...
    final List<Map<String,dynamic>> items=[
      {'name':'Scheduling', 'color':AppColors.controler_list_color_00,'fcolor':AppColors.controler_list_color_01},
      {'name':'Parenting', 'color':AppColors.controler_list_color_10,'fcolor':AppColors.controler_list_color_11},
      {'name':'Communication', 'color':AppColors.controler_list_color_20,'fcolor':AppColors.controler_list_color_21},
      {'name':'Success story', 'color':AppColors.controler_list_color_30,'fcolor':AppColors.controler_list_color_31},
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
