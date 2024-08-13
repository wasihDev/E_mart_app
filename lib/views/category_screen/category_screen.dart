import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/widgets.common/bg_widget2.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgwidegt(
      child: Scaffold(
          appBar: AppBar(
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      CategoryImages[index],
                      height: 120,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    10.heightBox,
                    // ignore: unnecessary_string_interpolations
                    "${categoriesList[index]}"
                        .text
                        .color(darkFontGrey)
                        .align(TextAlign.center)
                        .make(),
                  ],
                )
                    .box
                    .white
                    .rounded
                    .clip(Clip.antiAlias)
                    .outerShadowSm
                    .make()
                    .onTap(() {
                  // log("tile ${categoriesList[index]}");
                  // log('a ${controller.subcat[index]}');
                  controller.getSubCategory(categoriesList[index]);
                  Get.to(() => CategoryDetails(title: categoriesList[index]));
                });
              },
            ),
          )),
    );
  }
}
