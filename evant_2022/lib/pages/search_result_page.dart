import 'package:evant_2022/controllers/user_controller.dart';
import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/search_result_page/search_result_title_widget.dart';
import '../widgets/search_result_page/result_list_widget.dart';

import '../controllers/event_controller.dart';

class SearchResultPage extends StatefulWidget {
  final Map userDoc;
  final String keyword;
  const SearchResultPage({
    Key? key,
    required this.keyword,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  List eventSearchList = [];
  List userSearchList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EventController.instance.searchEvent(widget.keyword).then((result) {
      setState(() {
        eventSearchList = result;
      });
    });
    UserController.instance.searchUser(widget.keyword).then((result) {
      setState(() {
        print(result);
        userSearchList = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
        mobileVer: SearchResultMobilePage(
      userDoc: widget.userDoc,
      keyword: widget.keyword,
      eventList: eventSearchList,
      userList: userSearchList,
    ));
  }
}

// ----------------------------- MOBILE -------------------------- //

class SearchResultMobilePage extends StatefulWidget {
  final List eventList;
  final List userList;
  final String keyword;
  final Map userDoc;
  const SearchResultMobilePage({
    Key? key,
    required this.keyword,
    required this.userDoc,
    required this.eventList,
    required this.userList,
  }) : super(key: key);

  @override
  State<SearchResultMobilePage> createState() => _SearchResultMobilePageState();
}

class _SearchResultMobilePageState extends State<SearchResultMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            AppBarWidget(
              profileUrl: widget.userDoc['profilePicture'],
            ),
            SearchResultTitleWidget(
              keyword: widget.keyword,
            ),
            ResultListWidget(
              eventList: widget.eventList,
              userList: widget.userList,
              userData: widget.userDoc,
            ),
          ],
        ),
      ),
    );
  }
}
