import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

import './controllers/auth_controller.dart';
import './controllers/user_controller.dart';

import './widgets/loading_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then(
    (value) {
      Get.put(
        AuthController(),
      );
      Get.put(
        UserController(),
      );
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EVANT',
      theme: ThemeData(
        primaryColor: Colors.green[50],
      ),
      home: const LoadingWidget(),
    );
  }
}
