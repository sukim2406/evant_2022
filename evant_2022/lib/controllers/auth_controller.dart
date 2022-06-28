import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../pages/login_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(
      auth.userChanges(),
    );
    // ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(
        () => const LoginPage(),
      );
    } else {
      Get.offAll(
        () => const LoginPage(),
      );
    }
  }
}
