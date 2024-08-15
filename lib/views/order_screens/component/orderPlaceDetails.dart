import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/cupertino.dart';

Widget orderPlaceDetails(
    {required title1, required title2, required d1, required d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title1.toString(),
              style: const TextStyle(color: darkFontGrey, fontFamily: (bold)),
            ),
            Text(
              d1.toString(),
              style: const TextStyle(color: redColor, fontFamily: (semibold)),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              title2.toString(),
              style: const TextStyle(color: darkFontGrey, fontFamily: (bold)),
            ),
            Text(
              d2.toString(),
              style:
                  const TextStyle(color: darkFontGrey, fontFamily: (semibold)),
            ),
          ],
        )
      ],
    ),
  );
}
