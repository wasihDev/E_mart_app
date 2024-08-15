import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/colors.dart';
import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/consts/styles.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:flutter/material.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "My Wishlist",
            style: TextStyle(
                color: darkFontGrey, fontFamily: (semibold), fontSize: 18),
          ),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getWishlist(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No item found!'));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, index) {
                      var itemData = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListTile(
                          leading: SizedBox(
                              height: 50,
                              width: 70,
                              child: Image.network(
                                itemData['p_image'][0],
                                fit: BoxFit.fill,
                              )),
                          title: Text(
                            itemData["p_name"],
                            style: const TextStyle(
                                color: darkFontGrey, fontFamily: (semibold)),
                          ),
                          subtitle: Text(
                            "\$${itemData['p_price']}.0",
                            style: const TextStyle(
                                color: redColor, fontFamily: (bold)),
                          ),
                          trailing: IconButton(
                              onPressed: () async {
                                await firestore
                                    .collection(products)
                                    .doc(itemData.id)
                                    .set({
                                  'p_wishlist':
                                      FieldValue.arrayRemove([currentUser!.uid])
                                }, SetOptions(merge: true));
                              },
                              icon: const Icon(
                                Icons.favorite,
                                color: redColor,
                              )),
                        ),
                      );
                    });
              }
            }));
  }
}
