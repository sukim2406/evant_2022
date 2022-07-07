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

  Future updateProfilePicture(uid, url) async {
    bool result = false;
    try {
      await firestore
          .collection('users')
          .doc(uid)
          .update({'profilePicture': url}).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      return result;
    }
  }

  Future updateProfile(uid, url, screenName, greetMsg) async {
    bool result = false;
    try {
      await firestore.collection('users').doc(uid).update({
        'profilePicture': url,
        'screenName': screenName,
        'greetMsg': greetMsg,
      }).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      return result;
    }
  }

  Future updateProfileNoPicture(uid, screenName, greetMsg) async {
    bool result = false;
    try {
      await firestore.collection('users').doc(uid).update({
        'screenName': screenName,
        'greetMsg': greetMsg,
      }).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      return result;
    }
  }

  Future updateHomeground(uid, lat, lng) async {
    final Map newHomeground = {
      'lat': lat,
      'lng': lng,
    };
    bool result = false;
    try {
      await firestore.collection('users').doc(uid).update({
        'homeground': newHomeground,
      }).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      return result;
    }
  }

  Future updateMyEvent(uid, eventId) async {
    bool result = false;
    try {
      final Map userDoc = await getCurUser(uid);
      if (userDoc.isEmpty) {
        result = false;
      }
      List myEvents = [];
      if (userDoc['myEvents'] == null) {
        myEvents.add(eventId);
      } else {
        myEvents = userDoc['myEvents'];
        myEvents.add(eventId);
      }
      await firestore.collection('users').doc(uid).update({
        'myEvents': myEvents,
      }).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      print('updateMyEvent error : $e');
      return result;
    }
  }
}
