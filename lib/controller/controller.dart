import 'package:get/get.dart';

class DropGetXContoller extends GetxController {

  // It is mandatory initialize with one value from listType
  // ignore: non_constant_identifier_names
  final search_hint = "Select Using Country Code *".obs;
  final ccode = "no data".obs;
  final showError = false.obs;


  void setCountryCode(String value){
    ccode.value = value;
  }
  void changeErrorState(bool value){
    showError.value = value;
  }



}