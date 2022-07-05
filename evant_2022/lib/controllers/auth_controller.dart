import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controllers/user_controller.dart';
import '../controllers/sf_controller.dart';
import '../controllers/storage_controller.dart';

import '../pages/login_page.dart';
import '../pages/landing_page.dart';

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
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(
        () => const LoginPage(),
      );
    } else {
      Get.offAll(
        () => const LandingPage(),
      );
    }
  }

  login(String email, password) async {
    try {
      if (email.isEmail) {
        if (password.isNotEmpty) {
          try {
            UserCredential credential = await auth.signInWithEmailAndPassword(
                email: email, password: password);
            await SFController.instance
                .setCurUser(credential.user!.uid)
                .then((result) {
              return true;
            });
            return true;
          } on FirebaseAuthException catch (e) {
            Get.snackbar(
              'login error',
              e.toString(),
              backgroundColor: Colors.redAccent,
              snackPosition: SnackPosition.BOTTOM,
              titleText: const Text(
                'Account login failed',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
            return false;
          }
        } else {
          throw Exception('Check password input');
        }
      } else {
        throw Exception('Check email format');
      }
    } catch (e) {
      Get.snackbar(
        'login error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Account login failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      return false;
    }
  }

  logInGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await auth.signInWithCredential(credential).then((result) {
        var userDocData = {
          'uid': result.user?.uid,
          'email': result.user?.email,
          'screenName': result.user?.email,
          'greetMsg': 'Welcome to Evant!',
          'following': [],
          'homeground': {
            'lat': 37.532600,
            'lng': 127.024612,
          },
          'stats': {
            'hosted': 0,
            'attended': 0,
            'likes': 0,
          },
        };
        UserController.instance.createUserDoc(userDocData).then(
          (result) {
            if (result) {
              return true;
            }

            throw Exception('createUserDoc error');
          },
        );
        SFController.instance.setCurUser(result.user!.uid).then((result) {
          return result;
        });
      });
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Google LogIn Error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Google Account login failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      return false;
    }
  }

  void logout() async {
    await auth.signOut().then((result) {
      SFController.instance.clearSF();
    });
  }

  register(String email, password, password2, screenName) async {
    bool success = false;
    try {
      if (email.isEmail) {
        if (password.isNotEmpty && password2.isNotEmpty) {
          if (password == password2) {
            if (screenName.isNotEmpty) {
              await auth
                  .createUserWithEmailAndPassword(
                      email: email, password: password)
                  .then(
                (result) async {
                  await SFController.instance
                      .setCurUser(result.user!.uid)
                      .then((result) {
                    success = result;
                  });

                  var userDocData = {
                    'uid': result.user!.uid,
                    'email': email,
                    'screenName': screenName,
                    'profilePicture': await StorageController.instance
                        .getTempProfilePicture(),
                    'homeground': {
                      'lat': 37.532600,
                      'lng': 127.024612,
                    },
                    'greetMsg': 'Welcome to Evant!',
                    'following': [],
                    'stats': {
                      'hosted': 0,
                      'attended': 0,
                      'likes': 0,
                    },
                  };
                  await UserController.instance.createUserDoc(userDocData).then(
                    (result) {
                      if (result) {
                        success = true;
                        return true;
                      }
                      throw Exception('createUserDoc error');
                    },
                  );
                },
              );
              return success;
            } else {
              throw Exception('Screen name cannot be empty');
            }
          } else {
            throw Exception('Passwords does not match');
          }
        } else {
          throw Exception('Empty field detected');
        }
      } else {
        throw Exception('Check email format');
      }
    } catch (e) {
      Get.snackbar(
        'register error',
        e.toString(),
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          'Account registration failed',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
      return false;
    }
  }

  getCurUid() {
    var user = auth.currentUser;
    return user?.uid;
  }
}
