import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/map_screen_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/landing_page/welcome_message_widget.dart';
import '../widgets/landing_page/search_category_widget.dart';
import '../widgets/landing_page/search_following_widget.dart';
import '../widgets/landing_page/footer_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/sf_controller.dart';
import '../controllers/user_controller.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Map userData = {};

  @override
  void initState() {
    super.initState();
    SFControllers.instance.getCurUser().then(
      (result) {
        UserController.instance.getCurUser(result).then((result) {
          if (mounted) {
            setState(() {
              userData = result;
            });
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userData.isEmpty) {
      return const LoadingWidget();
    }
    return ResponsiveLayoutWidget(
      mobileVer: _LandingMobilePage(
        userData: userData,
      ),
      tabeltVer: LandingTabletPage(
        userData: userData,
      ),
    );
  }
}

// ------------------- MOBILE -------------- //

class _LandingMobilePage extends StatefulWidget {
  final Map userData;
  const _LandingMobilePage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<_LandingMobilePage> createState() => __LandingMobilePageState();
}

class __LandingMobilePageState extends State<_LandingMobilePage> {
  double initLat = global.initMapLat;
  double initLng = global.initMapLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initLat = widget.userData['homeground']['lat'];
      initLng = widget.userData['homeground']['lng'];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> listviewEntries = <String>['Sports', 'Study', 'Game'];
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            const AppBarWidget(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WelcomeMessageWidget(),
                    Container(
                      height: MediaQuery.of(context).size.width * .9,
                      width: MediaQuery.of(context).size.width * .9,
                      color: Colors.white,
                      child: MapScreenWidget(
                        initLat: initLat,
                        initLng: initLng,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    const SearchCategoryWidget(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    const SearchFollowingWidget(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    const FooterWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------------- TABLET --------------------------------//

class LandingTabletPage extends StatefulWidget {
  final Map userData;
  const LandingTabletPage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<LandingTabletPage> createState() => _LandingTabletPageState();
}

class _LandingTabletPageState extends State<LandingTabletPage> {
  double initLat = global.initMapLat;
  double initLng = global.initMapLng;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      initLat = widget.userData['homeground']['lat'];
      initLng = widget.userData['homeground']['lng'];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            const AppBarWidget(),
            Row(
              children: [
                Column(
                  children: [
                    const WelcomeMessageWidget(),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: MediaQuery.of(context).size.height * .45,
                      color: Colors.grey,
                      child: MapScreenWidget(
                        initLat: initLat,
                        initLng: initLng,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
                      height: MediaQuery.of(context).size.height * .25,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .25,
                      color: Colors.grey.shade200,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .6,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
