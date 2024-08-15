import 'package:emart_app/consts/firebase_const.dart';

class FirestoreServices {
// get user
  static getUser(uid) {
    return firestore
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  static getProducts(pCategory) {
    return firestore
        .collection(products)
        .where('p_category', isEqualTo: pCategory)
        .snapshots();
  }

  static getCart() {
    return firestore
        .collection("cart")
        .where('created_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static deleteCart(docId) {
    return firestore.collection("cart").doc(docId).delete();
  }

  static getChats(docId) {
    return firestore
        .collection(chatCollection)
        .doc(docId)
        .collection(messageCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllOrders() {
    return firestore
        .collection("orders")
        .where('order_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getWishlist() {
    return firestore
        .collection('products')
        .where('p_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessages() {
    return firestore
        .collection(chatCollection)
        .where('fromId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection('cart')
          .where('created_by', isEqualTo: currentUser!.uid)
          .get()
          .then((val) {
        return val.docs.length;
      }),
      firestore
          .collection('products')
          .where('p_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((val) {
        return val.docs.length;
      }),
      firestore
          .collection('orders')
          .where('order_by', isEqualTo: currentUser!.uid)
          .get()
          .then((val) {
        return val.docs.length;
      })
    ]);
    return res;
  }

  static allProducts() {
    return firestore.collection(products).snapshots();
  }

  static getFeaturedProducts() {
    return firestore
        .collection(products)
        .where('is_featured', isEqualTo: true)
        .get();
  }
}
