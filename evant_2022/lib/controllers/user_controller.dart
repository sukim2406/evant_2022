import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createUserDoc(data) async {
    try {
      await firestore.collection('users').doc(data['uid']).set(data).then(
        (result) {
          return true;
        },
      );
    } catch (e) {
      Get.snackbar(
        'createUserDoc Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Firestore user doc',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      return false;
    }
  }

  getCurUser(uid) async {
    try {
      return await firestore
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot ds) {
        return ds.data();
      });
    } catch (e) {
      print('getCurUser error');
    }
  }
}
