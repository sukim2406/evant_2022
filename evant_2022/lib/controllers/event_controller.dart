import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventController extends GetxController {
  static EventController instance = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  createEventDoc(data) async {
    await firestore.collection('events').doc(data['id']).set(data).onError(
      (e, _) {
        print('createEventDoc error $e');
        return null;
      },
    );
    return true;
  }
}
