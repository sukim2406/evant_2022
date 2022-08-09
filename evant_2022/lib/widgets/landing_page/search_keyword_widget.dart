import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class SearchKeywordWidget extends StatefulWidget {
  final Map userDoc;
  const SearchKeywordWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<SearchKeywordWidget> createState() => _SearchKeywordWidgetState();
}

class _SearchKeywordWidgetState extends State<SearchKeywordWidget> {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: SearchKeywordMobileWidget(
        searchController: searchController,
      ),
    );
  }
}

// --------------------------------- MOBILE ---------------------------//

class SearchKeywordMobileWidget extends StatefulWidget {
  final TextEditingController searchController;
  const SearchKeywordMobileWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  @override
  State<SearchKeywordMobileWidget> createState() =>
      _SearchKeywordMobileWidgetState();
}

class _SearchKeywordMobileWidgetState extends State<SearchKeywordMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .9,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Search By Keyword',
              style: GoogleFonts.yellowtail(
                color: global.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .1,
          width: MediaQuery.of(context).size.width * .9,
          color: Colors.red,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              hintText: 'Search event or people',
              hintStyle: const TextStyle(
                color: global.primaryColor,
              ),
              fillColor: global.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
