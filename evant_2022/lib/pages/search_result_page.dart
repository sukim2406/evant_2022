import 'package:flutter/material.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/search_result_page/search_result_title_widget.dart';
import '../widgets/search_result_page/result_list_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
        mobileVer: SearchResultMobilePage(
      userDoc: widget.userDoc,
      keyword: widget.keyword,
    ));
  }
}

// ----------------------------- MOBILE -------------------------- //

class SearchResultMobilePage extends StatefulWidget {
  final String keyword;
  final Map userDoc;
  const SearchResultMobilePage({
    Key? key,
    required this.keyword,
    required this.userDoc,
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
            ResultListWidget(),
          ],
        ),
      ),
    );
  }
}
