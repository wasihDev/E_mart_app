import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/items_details.dart';
import 'package:emart_app/widgets.common/bg_widget2.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgwidegt(
      child: Scaffold(
          appBar: AppBar(
            title: title!.text.fontFamily(bold).white.make(),
          ),
          body: StreamBuilder(
              stream: FirestoreServices.getProducts(title),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator(color: Colors.red);
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text(
                    'No Product Found!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ));
                } else {
                  return Container(
                      padding: const EdgeInsets.all(12),
                      child: Column(children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .rounded
                                    .white
                                    .size(120, 60)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()),
                          ),
                        ),
                        20.heightBox,
                        Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (context, index) {
                                  var itemData = snapshot.data!.docs[index];

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.network(itemData['p_image'][0],
                                          width: 200,
                                          height: 150,
                                          fit: BoxFit.cover),
                                      "${itemData['p_name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(darkFontGrey)
                                          .make(),
                                      10.heightBox,
                                      "\$${itemData['p_price']}"
                                          .text
                                          .color(redColor)
                                          .fontFamily(bold)
                                          .size(18)
                                          .make(),
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .roundedSM
                                      .outerShadowSm
                                      .padding(const EdgeInsets.all(12))
                                      .make()
                                      .onTap(() {
                                    Get.to(() => ItemsDetails(
                                        itemData: itemData,
                                        title: "${itemData['p_name']}"));
                                  });
                                }))
                      ]));
                }
              })),
    );
  }
}
