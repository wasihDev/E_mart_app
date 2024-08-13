import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/widgets.common/custom_textfield.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingDetailScreen extends StatelessWidget {
  const ShippingDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Info",
          style: TextStyle(
              color: darkFontGrey, fontSize: 16, fontFamily: (semibold)),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            title: 'Continue',
            Color: redColor,
            onPress: () {},
            textColor: whiteColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            textFieldwidget(
                title: "Address",
                // controller: controller.addressController,
                hint: "address"),
            textFieldwidget(
                title: "City",
                // controller: controller.cityController,
                hint: "City"),
            textFieldwidget(
                title: "State",
                // controller: controller.stateController,
                hint: "State"),
            textFieldwidget(
                title: "Postal Code",
                // controller: controller.postalController,
                hint: "Postal Code"),
            textFieldwidget(
                title: "Phone",
                // controller: controller.phoneController,
                hint: "Phone"),
          ],
        ),
      ),
    );
  }
}
