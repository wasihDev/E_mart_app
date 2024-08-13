import 'package:emart_app/consts/consts.dart';

Widget homeButtons({width, height, icon, title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icTodaysDeal,
        width: 26,
      ),
      5.heightBox,
      todaydeal.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).make();
}
