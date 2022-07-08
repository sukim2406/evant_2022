import 'dart:io';

import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../controllers/sf_controller.dart';

class StorageController extends GetxController {
  static StorageController instance = Get.find();
  FirebaseStorage storage = FirebaseStorage.instance;

  Future uploadTempProfilePicture() async {
    final File file = File('img/temp_profile.png');
    SFController.instance.getCurUser().then(
      (value) {
        final path = 'profileImgs/$value/temp_profile.png';
        final ref = storage.ref().child(path);
        ref.putFile(file);
      },
    );
  }

  Future getTempProfilePicture() async {
    try {
      final ref = await storage
          .ref('profileImgs/default/temp_profile.png')
          .getDownloadURL();

      return ref;
    } catch (e) {
      return '';
    }
  }

  Future uploadProfileImage(uid, image) async {
    bool result = false;
    try {
      await storage
          .ref()
          .child('profileImgs/$uid/profile.png')
          .putData(image)
          .then((path) {
        result = true;
      });
      return result;
    } catch (e) {
      print('uploadProfileImage error ${e.toString()}');
      return result;
    }
  }

  Future getProfileImageUrl(uid) async {
    String result = '';
    try {
      await storage
          .ref('profileImgs/$uid/profile.png')
          .getDownloadURL()
          .then((url) {
        result = url;
      });
      return result;
    } catch (e) {
      return result;
    }
  }

  Future uploadEventImage(id, image) async {
    bool result = false;
    try {
      await storage
          .ref()
          .child('eventImgs/$id.png')
          .putData(image)
          .then((path) {
        result = true;
      });
      return result;
    } catch (e) {
      print('uploadEventImage error ${e.toString()}');
      result = false;
      return result;
    }
  }

  Future getEventImageUrl(id) async {
    String result = '';
    try {
      await storage.ref('eventImgs/$id.png').getDownloadURL().then((url) {
        result = url;
      });
      return result;
    } catch (e) {
      print('getEventImageUrl error ${e.toString()}');
      return result;
    }
  }
}
