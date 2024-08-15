import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/order_screens/order_detail.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "My Orders",
            style: TextStyle(
                color: darkFontGrey, fontFamily: (semibold), fontSize: 18),
          ),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getAllOrders(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: const CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No orders found!'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      var itemData = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(),
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ListTile(
                              onTap: () {
                                Get.to(() => OrderDetailScreen(data: itemData));
                              },
                              // tileColor: const Color.fromARGB(255, 242, 242, 217),
                              leading: Text(
                                "(${index + 1})".toString(),
                                style: const TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: (semibold)),
                              ),
                              title: Text(
                                itemData['order_code'].toString(),
                                style: const TextStyle(
                                    color: darkFontGrey,
                                    fontFamily: (semibold)),
                              ),
                              subtitle: Text(
                                "\$${itemData['total_amount'].toString()}",
                                style: const TextStyle(
                                    color: redColor, fontFamily: (bold)),
                              ),
                              trailing: const IconButton(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: darkFontGrey,
                                  )),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
