import 'package:flutter/cupertino.dart';

Widget bgWidget({required String backgroundImage, Widget? child}) {
  return Container(
    height: double.infinity,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(backgroundImage),
        fit: BoxFit.fill,
      ),
    ),
    child: child,
  );
}
