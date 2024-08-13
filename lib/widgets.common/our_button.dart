import 'package:emart_app/consts/consts.dart';

Widget ourButton({
  onPress,
  Color,
  textColor,
  String? title,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: Color, padding: EdgeInsets.all(12)),
    onPressed: onPress,
    child: title!.text.color(textColor).fontFamily(bold).make(),
  );
}
