import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SFController extends GetxController {
  static SFController instance = Get.find();

  Future getSharedPreferences() async {
    SharedPreferences sf = await SharedPreferences.getInstance();

    return sf;
  }

  Future setCurUser(uid) async {
    SharedPreferences sf = await getSharedPreferences();

    bool result = await sf.setString('uid', uid);
    return result;
  }

  Future getCurUser() async {
    SharedPreferences sf = await getSharedPreferences();
    String curUser = sf.getString('uid') ?? '';
    return curUser;
  }

  Future clearSF() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    sf.remove('uid').then(
      (result) {
        if (result) {
          return true;
        } else {
          return false;
        }
      },
    );
  }
}
