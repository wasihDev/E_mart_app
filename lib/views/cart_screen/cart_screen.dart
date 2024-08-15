import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controller/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/shipping_detail.dart';
import 'package:emart_app/widgets.common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Shopping Cart",
              style: TextStyle(color: darkFontGrey),
            ),
          ),
          // bottomNavigationBar: SizedBox(
          //   height: 60,
          //   child: ourButton(
          //       title: "Proceed to Shipping",
          //       Color: redColor,
          //       onPress: () {},
          //       textColor: whiteColor),
          // ),
          body: StreamBuilder(
              stream: FirestoreServices.getCart(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No item found'),
                  );
                } else {
                  controller.calculatetotalPrices(snapshot.data!.docs);
                  controller.productSnapshot = snapshot.data!.docs;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      8.heightBox,
                                      ListTile(
                                        leading: CircleAvatar(
                                          child: Image.network(
                                            snapshot.data!.docs[index]
                                                ['p_image'],
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: Text(
                                          "${snapshot.data!.docs[index]['p_name']} (x${snapshot.data!.docs[index]['p_quantity']})",
                                          style: const TextStyle(
                                              color: darkFontGrey,
                                              fontFamily: (semibold),
                                              fontSize: 16),
                                        ),
                                        subtitle: Text(
                                          "\$${snapshot.data!.docs[index]['p_price']}",
                                          style: const TextStyle(
                                              color: redColor,
                                              fontFamily: (semibold)),
                                        ),
                                        trailing: InkWell(
                                            onTap: () {
                                              FirestoreServices.deleteCart(
                                                  snapshot
                                                      .data!.docs[index].id);
                                            },
                                            child: const Icon(Icons.delete)),
                                      ),
                                    ],
                                  );
                                })),
                        5.heightBox,
                        Container(
                          padding: const EdgeInsets.all(12),
                          width: context.screenWidth - 60,
                          decoration: BoxDecoration(
                              color: Colors.amber[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Price",
                                style: TextStyle(
                                    fontFamily: (semibold),
                                    color: darkFontGrey),
                              ),
                              Obx(() {
                                return Text(
                                  "\$${controller.totalPrice.value}",
                                  style: const TextStyle(
                                      fontFamily: (semibold), color: redColor),
                                );
                              })
                            ],
                          ),
                        ),
                        10.heightBox,
                        SizedBox(
                          width: context.screenWidth - 60,
                          child: ourButton(
                              title: "Proceed to Shipping",
                              Color: redColor,
                              onPress: () {
                                Get.to(() => const ShippingDetailScreen());
                              },
                              textColor: whiteColor),
                        )
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
