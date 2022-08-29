import 'package:flutter/material.dart';

import '../controllers/user_controller.dart';

import '../widgets/loading_widget.dart';
import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/user_page/user_tab_bar_widget.dart';
import '../widgets/user_page/user_info_widget.dart';
import '../widgets/user_page/user_area_widget.dart';
import '../widgets/user_page/user_follow_widget.dart';

class UserPage extends StatefulWidget {
  final Map myUserDoc;
  final String uid;
  const UserPage({
    Key? key,
    required this.uid,
    required this.myUserDoc,
  }) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Map userDoc = {};
  int index = 0;

  updatePage(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  getUserData() async {
    await UserController.instance.getCurUser(widget.uid).then((doc) {
      setState(
        () {
          userDoc = doc;
        },
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      UserInfoWidget(
        userDoc: userDoc,
        myUserDoc: widget.myUserDoc,
      ),
      UserAreaWidget(
        userDoc: userDoc,
        myUserDoc: widget.myUserDoc,
      ),
      UserFollowWidget(),
      const Text('events'),
    ];

    return (userDoc.isEmpty)
        ? const LoadingWidget()
        : ResponsiveLayoutWidget(
            mobileVer: UserMobilePage(
              pages: pages,
              userDoc: userDoc,
              index: index,
              updatePage: updatePage,
              myUserDoc: widget.myUserDoc,
            ),
          );
  }
}

// -------------------------- mobile -------------------- //

class UserMobilePage extends StatefulWidget {
  final List pages;
  final Map myUserDoc;
  final Map userDoc;
  final int index;
  final void Function(int) updatePage;
  const UserMobilePage({
    Key? key,
    required this.pages,
    required this.userDoc,
    required this.index,
    required this.updatePage,
    required this.myUserDoc,
  }) : super(key: key);

  @override
  State<UserMobilePage> createState() => _UserMobilePageState();
}

class _UserMobilePageState extends State<UserMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            AppBarMobileWidget(
              profileUrl: widget.myUserDoc['profilePicture'],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .9,
              color: Colors.grey,
              child: Column(
                children: [
                  UserTabBarWidget(
                    index: widget.index,
                    updatePage: widget.updatePage,
                  ),
                  widget.pages[widget.index],
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .9,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
