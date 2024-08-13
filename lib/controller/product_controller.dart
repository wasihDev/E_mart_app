import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:emart_app/services/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorPicker = 0.obs;
  var totalPrice = 0.obs;
  quantityIncrease(pQuantity) {
    if (quantity.value < pQuantity) {
      quantity.value++;
    }
  }

  quantitydecrease(pQuantity) {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  totalPriceFunc(int pTotalPrice) {
    totalPrice.value = pTotalPrice * quantity.value;
  }

  colorPick(index) {
    colorPicker.value = index;
  }

  getSubCategory(title) async {
    subcat.clear();
    var data =
        await rootBundle.loadString("lib/services/catagories_model.json");
    var decoded = categoryModelFromJson(data);

    var s = decoded.categories!.where((e) => e.name == title).toList();
    for (var e in s[0].subcategory!) {
      subcat.add(e);
    }
  }

  addToCart({name, price, img, qty, color, vender}) {
    firestore.collection('cart').doc().set({
      "p_name": name,
      "p_price": price,
      "p_image": img,
      "p_quantity": qty,
      "p_color": color,
      "created_by": currentUser!.uid,
      "vender_id": vender
    }).catchError((e) {
      errorSnack(e);
    });
  }

  clearValues() {
    colorPicker.value = 0;
    quantity.value = 0;
    totalPrice.value = 0;
  }
}
