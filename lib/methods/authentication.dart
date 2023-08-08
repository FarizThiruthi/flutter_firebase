import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_forebase/login_screen.dart';
import 'package:flutter_forebase/wish_page.dart';
import 'package:get/get.dart';

class Authentication extends GetxController {
  static Authentication instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, (callback) => _initialScreen(_user.value));
  }

  _initialScreen(User? user) {
    if (user == null) {
      //print('login Page');
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => WishPage());
    }
  }

  void register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        "Account Creation Error",
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, String password) async {
    try {
      //print('Logging in with email: $email');
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'An error occurred. Please try again later.';

      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password. Please check your password.';
      }

      //print('Error logging in: $e');

      Get.snackbar(
        "Login Error",
        errorMessage,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
