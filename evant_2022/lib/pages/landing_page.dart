import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/map_screen_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../controllers/sf_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    SFControllers.instance.getCurUser().then(
      (result) {
        // print('landing page initstate getCurUser result $result');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: _LandingMobilePage(),
    );
  }
}

// ------------------- MOBILE -------------- //

class _LandingMobilePage extends StatefulWidget {
  const _LandingMobilePage({Key? key}) : super(key: key);

  @override
  State<_LandingMobilePage> createState() => __LandingMobilePageState();
}

class __LandingMobilePageState extends State<_LandingMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: global.secondaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .5,
              width: MediaQuery.of(context).size.height * .5,
              color: Colors.white,
              child: const MapScreenWidget(),
            ),
            RoundedBtnWidget(
              height: null,
              width: null,
              func: () {
                AuthController.instance.logout();
              },
              label: 'LOG OUT',
              btnColor: global.primaryColor,
              txtColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
