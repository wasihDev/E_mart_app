import 'package:emart_app/consts/colors.dart';
import 'package:get/get.dart';

SnackbarController errorSnack(String error) {
  return Get.snackbar("Error", error,
      backgroundColor: redColor,
      colorText: whiteColor,
      snackPosition: SnackPosition.BOTTOM);
}

SnackbarController successSnack(String msg) {
  return Get.snackbar(
    'Updated',
    msg,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: green,
    colorText: whiteColor,
  );
}
