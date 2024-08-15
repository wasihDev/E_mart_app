import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/controller/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  var msgController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  late dynamic productSnapshot;
  var products = [];
  var placingOrder = false.obs;
  changepaymnentIndex(index) {
    paymentIndex.value = index;
  }

  calculatetotalPrices(data) {
    totalPrice.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalPrice.value =
          totalPrice.value + int.parse(data[i]['p_price'].toString());
    }
  }

  placeMyOrder({required orderPaymentmethod, required totalamount}) async {
    placingOrder(true);
    await getProductDetails();
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;

    await firestore.collection('orders').doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_date': DateTime.now(),
      'order_by_address': addressController.text,
      'order_by_state': stateController.text,
      'order_by_city': cityController.text,
      'order_by_phone': phoneController.text,
      'order_by_postalcode': postalController.text,
      'order_code': code,
      'shipping_method': 'Home Delivery',
      'payment_method': orderPaymentmethod,
      'order_placed': true,
      'order_confirmed': false,
      'order_delivered': false,
      'order_on_delivery': false,
      'total_amount': totalamount,
      'orders': FieldValue.arrayUnion(products)
    });
    placingOrder(false);
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'p_color': productSnapshot[i]['p_color'],
        'p_image': productSnapshot[i]['p_image'],
        'p_name': productSnapshot[i]['p_name'],
        'vender_id': productSnapshot[i]['vender_id'],
        't_price': productSnapshot[i]['p_price'],
        'p_quantity': productSnapshot[i]['p_quantity'],
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection('cart').doc(productSnapshot[i].id).delete();
    }
  }
}
