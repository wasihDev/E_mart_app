import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:emart_app/consts/firebase_const.dart';
import 'package:emart_app/consts/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  // Sign in
  Future<UserCredential?> signInMethod({email, password}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log("error1 $e");
      errorSnack(e.toString());
    }
    return userCredential;
  }

  // Sign up
  Future<UserCredential?> signUpMethod({email, password}) async {
    isLoading.value = true;
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      log("error2 $e");
      errorSnack(e.toString());
    }
    isLoading.value = false;

    return userCredential;
  }
// sign out

  signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      log("error3 $e");
      errorSnack(e.toString());
    }
  }

// storing user data in firebase
  storeData({email, name, password}) {
    DocumentReference ref =
        firestore.collection(userCollection).doc(currentUser!.uid);
    ref.set({
      'name': name,
      'email': email,
      'password': password,
      'imageUrl': '',
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",
      'uid': currentUser!.uid
    }, SetOptions(merge: true));
  }
}
