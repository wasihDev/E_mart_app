import 'dart:developer';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:emart_app/controller/product_controller.dart';
import 'package:emart_app/views/chat_screens/chat_screen.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:get/get.dart';

class ItemsDetails extends StatelessWidget {
  final String? title;
  final dynamic itemData;
  const ItemsDetails({super.key, required this.title, this.itemData});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return WillPopScope(
      onWillPop: () async {
        controller.clearValues();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            leading: InkWell(
                onTap: () {
                  Get.back();
                  controller.clearValues();
                },
                child: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: darkFontGrey,
                  )),
              Obx(() {
                return IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeToWishList(itemData.id);
                      } else {
                        controller.addToWishList(itemData.id);
                      }
                      log('id ${itemData.id}');
                    },
                    icon: controller.isFav.value
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(
                            Icons.favorite_outline,
                            color: darkFontGrey,
                          ));
              }),
            ],
          ),
          body: Column(children: [
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          VxSwiper.builder(
                              autoPlay: true,
                              height: 350,
                              itemCount: itemData["p_image"].length,
                              aspectRatio: 16 / 9,
                              viewportFraction: 1.0,
                              itemBuilder: (context, index) {
                                return Image.network(
                                  itemData['p_image'][index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              }),
                          10.heightBox,
                          title!.text
                              .size(16)
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          10.heightBox,
                          VxRating(
                            onRatingUpdate: (Value) {},
                            value: double.parse(itemData["p_rating"]),
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            count: 5,
                            size: 25,
                            isSelectable: false,
                            maxRating: 5,
                          ),
                          10.heightBox,
                          "\$${itemData["p_price"]}"
                              .text
                              .color(redColor)
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SizedBox(
                            // width: 100,
                            child: "Descrption:   "
                                .text
                                .color(Colors.black)
                                .bold
                                .make(),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: Text('${itemData["p_desc"]}'))
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          10.heightBox,
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Seller"
                                      .text
                                      .white
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  "${itemData["p_seller"]}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make(),
                                ],
                              )),
                              InkWell(
                                onTap: () {
                                  Get.to(() => const ChatScreen(), arguments: [
                                    itemData['p_seller'],
                                    itemData['vender_id'],
                                  ]);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.message_rounded,
                                    color: darkFontGrey,
                                  ),
                                ),
                              ),
                            ],
                          )
                              .box
                              .height(60)
                              .padding(
                                  const EdgeInsets.symmetric(horizontal: 16))
                              .color(textfieldGrey)
                              .make(),
                          Obx(() {
                            return Column(children: [
                              const SizedBox(height: 8),
                              // Color Widget
                              Row(
                                children: [
                                  SizedBox(
                                    child: "Color:"
                                        .text
                                        .color(textfieldGrey)
                                        .make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                      itemData["p_colors"].length,
                                      (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(40, 40)
                                              .roundedFull
                                              .color(Color(int.parse(
                                                  itemData["p_colors"][index])))
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .make()
                                              .onTap(() {
                                            controller.colorPick(index);
                                          }),
                                          Visibility(
                                            visible:
                                                controller.colorPicker.value ==
                                                    index,
                                            child: const Icon(
                                              Icons.task_alt_outlined,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  "Quantity:".text.color(textfieldGrey).make(),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.quantitydecrease(
                                                int.parse(
                                                    itemData["p_quantity"]));
                                            controller.totalPriceFunc(
                                                int.parse(itemData["p_price"]));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      "${controller.quantity.value}"
                                          .text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.quantityIncrease(
                                                int.parse(
                                                    itemData["p_quantity"]));
                                            controller.totalPriceFunc(
                                                int.parse(itemData["p_price"]));
                                          },
                                          icon: const Icon(Icons.add)),
                                      "(${itemData["p_quantity"]} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                ],
                              ).box.white.shadowSm.make(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Total:   ".text.color(Colors.black).make(),
                                  Text(
                                    '\$${controller.totalPrice.value}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  )
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ]);
                          }),
                        ])))),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: ourButton(
                  Color: redColor,
                  onPress: () {
                    if (controller.quantity.value != 0 ||
                        controller.totalPrice.value != 0) {
                      controller.addToCart(
                        color: itemData['p_colors']
                            [controller.colorPicker.value],
                        img: itemData["p_image"][0],
                        price: controller.totalPrice.value,
                        name: itemData["p_name"],
                        vender: itemData["vender_id"],
                        qty: controller.quantity.value,
                      );
                      successSnack('Item added to cart');
                    } else {
                      errorSnack('Please Select quantity');
                    }
                  },
                  textColor: whiteColor,
                  title: "Add to cart",
                ))
          ])),
    );
  }
}
