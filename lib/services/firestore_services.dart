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
}
