import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:flutter/material.dart';

Widget orderStatus({icon, title, showDone, color}) {
  return ListTile(
    title: const Divider(color: darkFontGrey, thickness: 1),
    leading: Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color, width: 3)),
      child: Icon(icon, color: color),
    ),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "$title",
            style: const TextStyle(color: darkFontGrey, fontFamily: (bold)),
          ),
          showDone ? const Icon(Icons.done, color: redColor) : Container()
        ],
      ),
    ),
  );
}
