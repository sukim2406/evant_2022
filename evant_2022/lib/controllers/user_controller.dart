import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../controllers/sf_controller.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createUserDoc(data) async {
    await firestore.collection('users').doc(data['uid']).set(data).onError(
      (e, _) {
        print(e);
        return null;
      },
    );
    return true;
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
      print(e.toString());
      print('getCurUser error');
    }
  }

  Future getProfilePicture() async {
    try {
      await firestore
          .collection('users')
          .doc(await SFController.instance.getCurUser())
          .get()
          .then((DocumentSnapshot ds) {
        return ds;
      });
    } catch (e) {
      print('getProfilePicture error $e');
    }
  }
}
