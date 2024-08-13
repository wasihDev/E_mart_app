import 'package:emart_app/consts/firebase_const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var username = '';

  getUserName() async {
    var e = await firestore
        .collection('users')
        .where('uid', isEqualTo: currentUser!.uid)
        .get()
        .then((onValue) {
      if (onValue.docs.isNotEmpty) {
        return onValue.docs.single['name'];
      }
    });
    username = e;
  }
}
