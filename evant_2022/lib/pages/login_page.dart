import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/boxed_textfield_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/loading_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/auth_controller.dart';

import '../pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: _LoginMobilePage(
        emailController: emailController,
        passwordController: passwordController,
      ),
      tabeltVer: _LoginTabletPage(
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}

// ---------------- MOBILE ----------------- //

class _LoginMobilePage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _LoginMobilePage({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<_LoginMobilePage> createState() => __LoginMobilePageState();
}

class __LoginMobilePageState extends State<_LoginMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                child: const Image(
                  image: AssetImage(
                    'img/logoevant.png',
                  ),
                ),
              ),
              Text(
                'LOG IN',
                style: GoogleFonts.yellowtail(
                  textStyle: const TextStyle(
                    color: global.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              BoxedTextFieldWidget(
                hintText: 'Email',
                width: MediaQuery.of(context).size.width * .6,
                controller: widget.emailController,
                obsecure: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .025,
              ),
              BoxedTextFieldWidget(
                hintText: 'Password',
                width: MediaQuery.of(context).size.width * .6,
                controller: widget.passwordController,
                obsecure: true,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              RoundedBtnWidget(
                height: null,
                width: MediaQuery.of(context).size.width * .6,
                func: () {
                  AuthController.instance
                      .login(
                    widget.emailController.text,
                    widget.passwordController.text,
                  )
                      .then(
                    (result) {
                      if (!result) {
                        Navigator.pop(context);
                      }
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoadingWidget(),
                    ),
                  );
                },
                label: 'LOG IN',
                btnColor: global.primaryColor,
                txtColor: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .0125,
              ),
              const Text(
                'or',
                style: TextStyle(
                  color: global.secondaryColor,
                ),
              ),
              const Text(
                'log in with',
                style: TextStyle(
                  color: global.secondaryColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .0125,
              ),
              SizedBox(
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    AuthController.instance.logInGoogle();
                  },
                  child: const Image(
                    image: AssetImage(
                      'img/google.png',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: const Divider(
                  height: 20,
                  thickness: 2,
                  color: global.primaryColor,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Do not have an account ? ',
                  style: const TextStyle(
                    color: global.secondaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'REGISTER',
                      style: const TextStyle(
                        color: global.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                                (route) => false,
                              ),
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ------------------- Tablet ------------------------- //

class _LoginTabletPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const _LoginTabletPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<_LoginTabletPage> createState() => __LoginTabletPageState();
}

class __LoginTabletPageState extends State<_LoginTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .2,
                    child: const Image(
                      image: AssetImage(
                        'img/logoevant.png',
                      ),
                    ),
                  ),
                  Text(
                    'LOG IN',
                    style: GoogleFonts.yellowtail(
                      textStyle: const TextStyle(
                        color: global.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxedTextFieldWidget(
                    hintText: 'Email',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.emailController,
                    obsecure: false,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  BoxedTextFieldWidget(
                    hintText: 'Password',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.passwordController,
                    obsecure: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                  ),
                  RoundedBtnWidget(
                    height: null,
                    width: MediaQuery.of(context).size.width * .4,
                    func: () {
                      AuthController.instance
                          .login(
                        widget.emailController.text,
                        widget.passwordController.text,
                      )
                          .then(
                        (result) {
                          if (!result) {
                            Navigator.pop(context);
                          }
                        },
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingWidget(),
                        ),
                      );
                    },
                    label: 'LOG IN',
                    btnColor: global.primaryColor,
                    txtColor: Colors.white,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0125,
                  ),
                  const Text(
                    'or',
                    style: TextStyle(
                      color: global.secondaryColor,
                    ),
                  ),
                  const Text(
                    'log in with',
                    style: TextStyle(
                      color: global.secondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .0125,
                  ),
                  SizedBox(
                    height: 40,
                    child: GestureDetector(
                      onTap: () {
                        AuthController.instance.logInGoogle();
                      },
                      child: const Image(
                        image: AssetImage(
                          'img/google.png',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Divider(
                      height: 20,
                      thickness: 2,
                      color: global.primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Do not have an account ? ',
                      style: const TextStyle(
                        color: global.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'REGISTER',
                          style: const TextStyle(
                            color: global.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ),
                                    (route) => false,
                                  ),
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
