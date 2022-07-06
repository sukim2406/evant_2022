import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/profile_page/tab_bar_widget.dart';
import '../widgets/profile_page/my_info_widget.dart';
import '../widgets/profile_page/my_area_widget.dart';

import '../controllers/sf_controller.dart';
import '../controllers/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map userDoc = {};
  int index = 0;

  updatePage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  getCurUserData() async {
    String uid = await SFController.instance.getCurUser();
    await UserController.instance.getCurUser(uid).then((doc) {
      setState(() {
        userDoc = doc;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCurUserData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      MyInfoWidget(userDoc: userDoc),
      MyAreaWidget(userDoc: userDoc),
      const Text('my events'),
      const Text('past events'),
      const Text('following'),
      const Text('account'),
    ];

    return (userDoc.isEmpty)
        ? const LoadingWidget()
        : ResponsiveLayoutWidget(
            mobileVer: ProfileMobilePage(
              userDoc: userDoc,
              updatePage: updatePage,
              index: index,
              pages: pages,
            ),
          );
  }
}

// ---------------------- MOBILE ---------------------------- //

class ProfileMobilePage extends StatefulWidget {
  final List pages;
  final Map userDoc;
  final int index;
  final void Function(int) updatePage;
  const ProfileMobilePage({
    Key? key,
    required this.userDoc,
    required this.updatePage,
    required this.index,
    required this.pages,
  }) : super(key: key);

  @override
  State<ProfileMobilePage> createState() => _ProfileMobilePageState();
}

class _ProfileMobilePageState extends State<ProfileMobilePage> {
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
              profileUrl: widget.userDoc['profilePicture'],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .85,
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                children: [
                  TabBarWidget(
                    index: widget.index,
                    updatePage: widget.updatePage,
                  ),
                  widget.pages[widget.index],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
