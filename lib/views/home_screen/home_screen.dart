import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/items_details.dart';
import 'package:emart_app/views/home_screen/components/featured_button.dart';
import 'package:emart_app/widgets.common/home_buttons.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: textfieldGrey)),
              ),
            ),
            VxSwiper.builder(
                aspectRatio: 16 / 9,
                autoPlay: true,
                height: 100,
                enlargeCenterPage: true,
                itemCount: slidersList.length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    slidersList[index],
                    fit: BoxFit.fitWidth,
                  )
                      .box
                      .rounded
                      .clip(Clip.antiAlias)
                      .margin(const EdgeInsets.symmetric(horizontal: 8))
                      .make();
                }),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  2,
                  (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth / 2.5,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        title: index == 0 ? todaydeal : flashsale,
                      )),
            ),
            10.heightBox,
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 100,
                    enlargeCenterPage: true,
                    itemCount: secondslidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondslidersList[index],
                        fit: BoxFit.fitWidth,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    }),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      3,
                      (index) => homeButtons(
                            height: context.screenHeight * 0.15,
                            width: context.screenWidth / 3.5,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brand
                                    : topSellers,
                          )),
                ),
                20.heightBox,
                Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make()),
                20.heightBox,
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        3,
                        (index) => Column(
                              children: [
                                featuredButton(
                                    Icon: featuredImages1[index],
                                    title: featuredTitles1[index]),
                                10.heightBox,
                                featuredButton(
                                    Icon: featuredImages2[index],
                                    title: featuredTitles2[index]),
                              ],
                            )).toList(),
                  ),
                ),
                20.heightBox,
                FutureBuilder(
                    future: FirestoreServices.getFeaturedProducts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No item found!'));
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: const BoxDecoration(color: redColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              featuredProduct.text.white
                                  .fontFamily(bold)
                                  .make(),
                              10.heightBox,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                      snapshot.data!.docs.length,
                                      (index) => InkWell(
                                            onTap: () {
                                              Get.to(() => ItemsDetails(
                                                    title: snapshot.data!
                                                        .docs[index]['p_name'],
                                                    itemData: snapshot
                                                        .data!.docs[index],
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                    snapshot.data!.docs[index]
                                                        ['p_image'][0],
                                                    width: 150,
                                                    height: 150,
                                                    fit: BoxFit.cover),
                                                10.heightBox,
                                                "${snapshot.data!.docs[index]['p_name']}"
                                                    .text
                                                    .fontFamily(semibold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                10.heightBox,
                                                "\$${snapshot.data!.docs[index]['p_price']}"
                                                    .text
                                                    .color(redColor)
                                                    .fontFamily(bold)
                                                    .size(18)
                                                    .make(),
                                              ],
                                            )
                                                .box
                                                .white
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .roundedSM
                                                .padding(
                                                    const EdgeInsets.all(8))
                                                .make(),
                                          )),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                20.heightBox,
                VxSwiper.builder(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    height: 100,
                    enlargeCenterPage: true,
                    itemCount: secondslidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondslidersList[index],
                        fit: BoxFit.fitWidth,
                      )
                          .box
                          .rounded
                          .clip(Clip.antiAlias)
                          .margin(const EdgeInsets.symmetric(horizontal: 8))
                          .make();
                    }),
                20.heightBox,
                StreamBuilder(
                    stream: FirestoreServices.allProducts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.data!.docs.isEmpty) {
                        return const Center(child: Text('No item found!'));
                      } else {
                        return GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300),
                            itemBuilder: (context, index) {
                              var itemData = snapshot.data!.docs[index];
                              return InkWell(
                                onTap: () {
                                  Get.to(() => ItemsDetails(
                                        title: itemData['p_name'],
                                        itemData: itemData,
                                      ));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network("${itemData['p_image'][0]}",
                                        width: 400,
                                        height: 200,
                                        fit: BoxFit.cover),
                                    Spacer(),
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
                                    .margin(EdgeInsets.symmetric(horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make(),
                              );
                            });
                      }
                    })
              ]),
            )
          ],
        ),
      )),
    );
  }
}
