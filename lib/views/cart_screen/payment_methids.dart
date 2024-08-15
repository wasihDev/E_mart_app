import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Choose Payment Method",
          style: TextStyle(
              color: darkFontGrey, fontSize: 16, fontFamily: (semibold)),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(() {
          return controller.placingOrder.value
              ? const Center(child: CircularProgressIndicator())
              : ourButton(
                  title: 'Place My Order',
                  Color: redColor,
                  onPress: () async {
                    await controller.placeMyOrder(
                      orderPaymentmethod: controller.paymentIndex.value,
                      totalamount: controller.totalPrice.value,
                    );
                    await controller.clearCart();
                    successSnack("order paced successfully");
                    Get.offAll(() => const Home());
                  },
                  textColor: whiteColor);
        }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(() {
          return Column(
            children: List.generate(3, (index) {
              return InkWell(
                onTap: () {
                  controller.paymentIndex(index);
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 3),
                      borderRadius: BorderRadius.circular(14)),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentImgList[index],
                        color: Colors.black.withOpacity(0.5),
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        width: double.infinity,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.4,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          paymentNameList[index],
                          style: const TextStyle(
                              color: whiteColor,
                              fontFamily: (semibold),
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}
