import 'package:get/get.dart';

class HelpSupportController extends GetxController{

  var selectedTab =0.obs;
  void changeTab(int index){
    selectedTab.value= index;
  }
}