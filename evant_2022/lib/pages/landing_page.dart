import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/map_screen_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/landing_page/welcome_message_widget.dart';
import '../widgets/landing_page/search_category_widget.dart';
import '../widgets/landing_page/search_following_widget.dart';
import '../widgets/landing_page/footer_widget.dart';
import '../widgets/landing_page/my_events_widget.dart';

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
  String curUser = '';

  @override
  void initState() {
    super.initState();
    SFController.instance.getCurUser().then(
      (result) {
        setState(() {
          curUser = result;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (curUser.isEmpty)
        ? const LoadingWidget()
        : FutureBuilder(
            future: UserController.instance.getCurUser(curUser),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ResponsiveLayoutWidget(
                  mobileVer: _LandingMobilePage(
                    userData: snapshot.data as Map,
                  ),
                  tabeltVer: LandingTabletPage(
                    userData: snapshot.data as Map,
                  ),
                );
              } else {
                return const LoadingWidget();
              }
            },
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
            AppBarWidget(
              profileUrl: widget.userData['profilePicture'],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .9,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const WelcomeMessageWidget(),
                    MapScreenWidget(
                      userDoc: widget.userData,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    SearchCategoryWidget(
                      userDoc: widget.userData,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    const MyEventsWidget(),
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
            AppBarWidget(
              profileUrl: widget.userData['profilePicture'],
            ),
            Row(
              children: [
                Column(
                  children: [
                    const WelcomeMessageWidget(),
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width * .65,
                    //   height: MediaQuery.of(context).size.height * .45,
                    //   child: MapScreenWidget(
                    //     initLat: initLat,
                    //     initLng: initLng,
                    //   ),
                    // ),
                    SearchCategoryWidget(
                      userDoc: widget.userData,
                    ),
                  ],
                ),
                Column(
                  children: const [
                    MyEventsWidget(),
                    SearchFollowingWidget(),
                  ],
                ),
              ],
            ),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
