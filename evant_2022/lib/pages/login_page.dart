import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: _LoginMobilePage(),
    );
  }
}

// --------------------------------- //

class _LoginMobilePage extends StatefulWidget {
  const _LoginMobilePage({Key? key}) : super(key: key);

  @override
  State<_LoginMobilePage> createState() => __LoginMobilePageState();
}

class __LoginMobilePageState extends State<_LoginMobilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              TextField(
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
