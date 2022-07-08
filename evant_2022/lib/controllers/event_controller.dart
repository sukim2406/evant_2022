import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:math';

class EventController extends GetxController {
  static EventController instance = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  calculateDistance(double lat1, double lat2, double lng1, double lng2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;

    return 12742000 * asin(sqrt(a));
  }

  createEventDoc(data) async {
    await firestore.collection('events').doc(data['id']).set(data).onError(
      (e, _) {
        print('createEventDoc error $e');
        return null;
      },
    );
    return true;
  }

  getEvents(double homegroundLat, double homegroundLng) async {
    // double latLessLimit = homegroundLat - .1;
    // double latGreaterLimit = homegroundLat + .1;
    // double lngLessLimit = homegroundLng - .2;
    // double lngGreaterLimit = homegroundLng + .2;
    List result = [];
    await firestore
        .collection('events')
        .where('open', isEqualTo: true)
        // .where('lat', isGreaterThan: latLessLimit)
        // .where('lng', isGreaterThan: lngLessLimit)
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((doc) {
        if (calculateDistance(
                doc['lat'], homegroundLat, doc['lng'], homegroundLng) <
            10000) {
          result.add(doc.data());
        }
      });
    });

    return result;
  }
}
