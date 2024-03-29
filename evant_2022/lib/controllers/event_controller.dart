import 'package:evant_2022/controllers/user_controller.dart';
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

  Future getEventDoc(eventId) async {
    try {
      return await firestore
          .collection('events')
          .doc(eventId)
          .get()
          .then((DocumentSnapshot result) {
        return result.data();
      });
    } catch (e) {
      print('getEventDoc error $e');
    }
  }

  getEventsByCategory(
      double homegroundLat, double homegroundLng, String category) async {
    List result = [];
    await firestore
        .collection('events')
        .where('category', isEqualTo: category)
        .get()
        .then(
      (QuerySnapshot qs) {
        qs.docs.forEach(
          (doc) {
            var eventData = doc.data() as Map;
            var distance = calculateDistance(
              doc['location']['lat'],
              homegroundLat,
              doc['location']['lng'],
              homegroundLng,
            );
            if (distance < 10000) {
              eventData['distance'] = distance;
              result.add(eventData);
            }
          },
        );
      },
    );
    return result;
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
        var eventData = doc.data() as Map;
        var distance = calculateDistance(doc['location']['lat'], homegroundLat,
            doc['location']['lng'], homegroundLng);
        if (distance < 10000) {
          eventData['distance'] = distance;
          result.add(eventData);
        }
      });
    });

    return result;
  }

  Future updateEventRSVP(Map userDoc, Map eventData) async {
    bool result = false;
    List newList = [];
    if (eventData['rsvpList'].contains(userDoc['uid'])) {
      newList = eventData['rsvpList'];
      newList.remove(userDoc['uid']);
    } else {
      newList = eventData['rsvpList'];
      newList.add(userDoc['uid']);
    }
    await firestore.collection('events').doc(eventData['id']).update(
      {
        'rsvpList': newList,
      },
    ).then((value) {
      result = true;
    });
    return result;
  }

  Future closeEvent(eventId) async {
    bool result = false;
    try {
      final Map eventDoc = await getEventDoc(eventId);
      await firestore.collection('events').doc(eventId).update(
        {'open': false},
      ).then((value) async {
        eventDoc['rsvpList'].forEach((attendee) async {
          await UserController.instance
              .closeEvent(eventId, attendee)
              .then((closed) {
            print('UserContoller closeEvent result $closed');
            result = closed;
          });
        });
      });
      return result;
    } catch (e) {
      print('closeEvent error $e');
      return result;
    }
  }

  Future deleteEvent(eventId) async {
    bool result = false;
    try {
      await firestore
          .collection('events')
          .doc(eventId)
          .delete()
          .then((deleteResult) {
        result = true;
      });
      return result;
    } catch (e) {
      print('EventController deleteEvent error : $e');
      return result;
    }
  }

  Future updateEvent(eventId, title, description, category, max, status,
      startTime, endTime) async {
    bool result = false;
    Map newTime = {
      'start': startTime,
      'end': endTime,
    };
    await firestore.collection('events').doc(eventId).update(
      {
        'title': title,
        'description': description,
        'category': category,
        'max': max,
        'status': status,
        'time': newTime,
      },
    ).then((value) {
      result = true;
    });
    return result;
  }

  Future searchEvent(String keyword) async {
    List searchResult = [];
    await firestore
        .collection('events')
        .where('title', isGreaterThanOrEqualTo: keyword)
        .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get()
        .then(
      (QuerySnapshot qs) {
        qs.docs.forEach(
          (element) {
            if (searchResult.isEmpty) {
              searchResult.add(element.data());
            } else {
              for (var map in searchResult) {
                if (map['id'] != element['id']) {
                  searchResult.add(element.data());
                }
              }
            }
          },
        );
      },
    );
    await firestore
        .collection('events')
        .where('description', isGreaterThanOrEqualTo: keyword)
        .where('description', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get()
        .then(
      (QuerySnapshot qs) {
        qs.docs.forEach(
          (element) {
            if (searchResult.isEmpty) {
              searchResult.add(element.data());
            } else {
              for (var map in searchResult) {
                if (map['id'] != element['id']) {
                  searchResult.add(element.data());
                }
              }
            }
          },
        );
      },
    );

    return searchResult;
  }

  Future searchEventByTitle(String keyword, List list) async {
    await firestore
        .collection('events')
        .where('title', isGreaterThanOrEqualTo: keyword)
        .where('title', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get()
        .then(
      (QuerySnapshot qs) {
        qs.docs.forEach((element) {
          if (!list.contains(element)) {
            list.add(element.data());
          }
        });
      },
    );
  }

  Future searchEventByDescription(String keyword, List list) async {
    await firestore
        .collection('events')
        .where('description', isGreaterThanOrEqualTo: keyword)
        .where('description', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get()
        .then((QuerySnapshot qs) {
      qs.docs.forEach((element) {
        if (!list.contains(element)) {
          list.add(element.data());
        }
      });
    });
  }
}
