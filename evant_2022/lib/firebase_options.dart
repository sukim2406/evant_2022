// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBDYftl-u6G2SIqB35YjJ5b0RTrZVsaDlM',
    appId: '1:1019447833203:web:e2843cb3586a00196d7006',
    messagingSenderId: '1019447833203',
    projectId: 'evant2022-b5801',
    authDomain: 'evant2022-b5801.firebaseapp.com',
    storageBucket: 'evant2022-b5801.appspot.com',
    measurementId: 'G-ZVJLK4LNZY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHOAFBpLOBBZuUi653PNtX9LgRepURnaU',
    appId: '1:1019447833203:android:3048bdcc105ff1536d7006',
    messagingSenderId: '1019447833203',
    projectId: 'evant2022-b5801',
    storageBucket: 'evant2022-b5801.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8yTfARkPrchiU4uRSSZ8gpLesL6HhahY',
    appId: '1:1019447833203:ios:b0995b56c4d77b3c6d7006',
    messagingSenderId: '1019447833203',
    projectId: 'evant2022-b5801',
    storageBucket: 'evant2022-b5801.appspot.com',
    iosClientId: '1019447833203-0jnno34fnvfvfumujt28v5nk7seudj3v.apps.googleusercontent.com',
    iosBundleId: 'com.example.evant2022',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8yTfARkPrchiU4uRSSZ8gpLesL6HhahY',
    appId: '1:1019447833203:ios:b0995b56c4d77b3c6d7006',
    messagingSenderId: '1019447833203',
    projectId: 'evant2022-b5801',
    storageBucket: 'evant2022-b5801.appspot.com',
    iosClientId: '1019447833203-0jnno34fnvfvfumujt28v5nk7seudj3v.apps.googleusercontent.com',
    iosBundleId: 'com.example.evant2022',
  );
}