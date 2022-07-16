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
      } else if (userDoc['myEvents'].contains(eventId)) {
        myEvents = userDoc['myEvents'];
        myEvents.remove(eventId);
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

  Future updateClosedEvent(uid, eventId) async {
    bool result = false;
    try {
      final Map userDoc = await getCurUser(uid);
      if (userDoc.isEmpty) {
        result = false;
      }
      List closedEvents = [];
      if (userDoc['closedEvents'] == null) {
        closedEvents.add(eventId);
      } else if (userDoc['closedEvents'].contains(eventId)) {
        print('already closed event');
        result = false;
        return result;
      } else {
        closedEvents = userDoc['closedEvents'];
        closedEvents.add(eventId);
      }
      await firestore.collection('users').doc(uid).update({
        'closedEvents': closedEvents,
      }).then((value) {
        result = true;
      });
      return result;
    } catch (e) {
      print('updateClosedEvent error $e');
      return result;
    }
  }

  Future<String> getScreenName(uid) async {
    String result = 'null';
    try {
      final Map userDoc = await getCurUser(uid);
      if (userDoc.isEmpty) {
        return result;
      } else {
        result = userDoc['screenName'];
        return result;
      }
    } catch (e) {
      print('getScreenName error : $e');
      return result;
    }
  }

  Future<String> getProfileUrl(uid) async {
    String result = 'null';
    try {
      final Map userDoc = await getCurUser(uid);
      if (userDoc.isEmpty) {
        return result;
      } else {
        result = userDoc['profilePicture'];
        return result;
      }
    } catch (e) {
      print('getProfileUrl error : $e');
      return result;
    }
  }

  Future closeEvent(eventId, uid) async {
    bool result = false;
    await updateClosedEvent(uid, eventId).then((updateClosedEventResult) {
      print('UserContoller updateClosedEventResult $updateClosedEventResult');
      if (updateClosedEventResult) {
        result = true;
      } else {
        result = false;
        print('updateClosedEvent error');
      }
    });
    await updateMyEvent(uid, eventId).then((updateMyEventResult) {
      print('UserContoller updateMyEventResult $updateMyEventResult');
      if (updateMyEventResult) {
        result = true;
      } else {
        result = false;
        print('updateMyEvent error');
      }
    });
    return result;
  }

  Future cancelEvent(String eventId, List rsvpList) async {
    bool result = false;
    try {
      rsvpList.forEach((attendee) async {
        await updateMyEvent(attendee, eventId).then(
          (updateMyEventResult) {
            if (updateMyEventResult) {
              result = true;
            } else {
              result = false;
            }
          },
        );
      });
      return result;
    } catch (e) {
      print('UserController cancelEvent error : $e');
      return result;
    }
  }
}
