import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/cupertino.dart';

Widget detailCart(
    {required String title, required width, required String count}) {
  return Container(
    height: 70,
    width: width,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(10)),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count,
          style: const TextStyle(
              color: darkFontGrey, fontFamily: bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        Text(title,
            style: const TextStyle(color: darkFontGrey),
            textAlign: TextAlign.center),
      ],
    ),
  );
}
