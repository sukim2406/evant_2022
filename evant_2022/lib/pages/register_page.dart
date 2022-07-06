import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/boxed_textfield_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/loading_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/auth_controller.dart';

import '../pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController screenNameController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode password2Focus = FocusNode();
  FocusNode screenNameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: _RegisterMobilePage(
        emailController: emailController,
        passwordController: passwordController,
        password2Controller: password2Controller,
        screenNameController: screenNameController,
        emailFocus: emailFocus,
        passwordFocus: passwordFocus,
        password2Focus: password2Focus,
        screenNameFocus: screenNameFocus,
      ),
      tabeltVer: _RegisterTabletPage(
        emailController: emailController,
        passwordController: passwordController,
        password2Controller: password2Controller,
        screenNameController: screenNameController,
        emailFocus: emailFocus,
        passwordFocus: passwordFocus,
        password2Focus: password2Focus,
        screenNameFocus: screenNameFocus,
      ),
    );
  }
}

// ------------------------ Mobile --------------------------- //

class _RegisterMobilePage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password2Controller;
  final TextEditingController screenNameController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final FocusNode password2Focus;
  final FocusNode screenNameFocus;

  const _RegisterMobilePage({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.password2Controller,
    required this.screenNameController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.password2Focus,
    required this.screenNameFocus,
  }) : super(key: key);

  @override
  State<_RegisterMobilePage> createState() => __RegisterMobilePageState();
}

class __RegisterMobilePageState extends State<_RegisterMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              'REGISTER',
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
              enabled: true,
              hintText: 'Email',
              width: MediaQuery.of(context).size.width * .6,
              controller: widget.emailController,
              obsecure: false,
              focusNode: widget.emailFocus,
              autoFocus: true,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            BoxedTextFieldWidget(
              enabled: true,
              hintText: 'Password',
              width: MediaQuery.of(context).size.width * .6,
              controller: widget.passwordController,
              obsecure: true,
              focusNode: widget.passwordFocus,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            BoxedTextFieldWidget(
              enabled: true,
              hintText: 'Password Confirm',
              width: MediaQuery.of(context).size.width * .6,
              controller: widget.password2Controller,
              obsecure: true,
              focusNode: widget.password2Focus,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            BoxedTextFieldWidget(
              enabled: true,
              hintText: 'Screen Name',
              width: MediaQuery.of(context).size.width * .6,
              controller: widget.screenNameController,
              obsecure: false,
              focusNode: widget.screenNameFocus,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .025,
            ),
            RoundedBtnWidget(
              height: null,
              width: MediaQuery.of(context).size.width * .6,
              func: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingWidget(),
                  ),
                );
                AuthController.instance
                    .register(
                  widget.emailController.text,
                  widget.passwordController.text,
                  widget.password2Controller.text,
                  widget.screenNameController.text,
                )
                    .then(
                  (result) {
                    if (!result) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterPage(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                );
              },
              label: 'REGISTER',
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
                text: 'Already have an account ? ',
                style: const TextStyle(
                  color: global.secondaryColor,
                ),
                children: [
                  TextSpan(
                    text: 'LOG IN',
                    style: const TextStyle(
                      color: global.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
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
    );
  }
}

//-------------------------------- TABLET --------------------------//

class _RegisterTabletPage extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController password2Controller;
  final TextEditingController screenNameController;

  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final FocusNode password2Focus;
  final FocusNode screenNameFocus;
  const _RegisterTabletPage({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.password2Controller,
    required this.screenNameController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.password2Focus,
    required this.screenNameFocus,
  }) : super(key: key);

  @override
  State<_RegisterTabletPage> createState() => __RegisterTabletPageState();
}

class __RegisterTabletPageState extends State<_RegisterTabletPage> {
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
                    'REGISTER',
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
                    enabled: true,
                    hintText: 'Email',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.emailController,
                    obsecure: false,
                    focusNode: widget.emailFocus,
                    autoFocus: true,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  BoxedTextFieldWidget(
                    enabled: true,
                    hintText: 'Password',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.passwordController,
                    obsecure: true,
                    focusNode: widget.passwordFocus,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  BoxedTextFieldWidget(
                    enabled: true,
                    hintText: 'Password Confirm',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.password2Controller,
                    obsecure: true,
                    focusNode: widget.password2Focus,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  BoxedTextFieldWidget(
                    enabled: true,
                    hintText: 'Screen Name',
                    width: MediaQuery.of(context).size.width * .5,
                    controller: widget.screenNameController,
                    obsecure: false,
                    focusNode: widget.screenNameFocus,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  RoundedBtnWidget(
                    height: null,
                    width: MediaQuery.of(context).size.width * .4,
                    func: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoadingWidget(),
                        ),
                      );
                      AuthController.instance
                          .register(
                        widget.emailController.text,
                        widget.passwordController.text,
                        widget.password2Controller.text,
                        widget.screenNameController.text,
                      )
                          .then(
                        (result) {
                          if (!result) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const RegisterPage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                      );
                    },
                    label: 'REGISTER',
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
                      text: 'Already have an account ? ',
                      style: const TextStyle(
                        color: global.secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'LOG IN',
                          style: const TextStyle(
                            color: global.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage(),
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
