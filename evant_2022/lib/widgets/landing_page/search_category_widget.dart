import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';

import '../../pages/category_page.dart';

class SearchCategoryWidget extends StatefulWidget {
  final Map userDoc;
  const SearchCategoryWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<SearchCategoryWidget> createState() => _SearchCategoryWidgetState();
}

class _SearchCategoryWidgetState extends State<SearchCategoryWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: SearchCategoryMobileWidget(
        controller: scrollController,
        userDoc: widget.userDoc,
      ),
      tabeltVer: SearchCategoryTabletWidget(
        controller: scrollController,
      ),
    );
  }
}

// --------------------------- MOBILE ------------------------ //

class SearchCategoryMobileWidget extends StatefulWidget {
  final Map userDoc;
  final ScrollController controller;
  const SearchCategoryMobileWidget({
    Key? key,
    required this.controller,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<SearchCategoryMobileWidget> createState() =>
      _SearchCategoryMobileWidgetState();
}

class _SearchCategoryMobileWidgetState
    extends State<SearchCategoryMobileWidget> {
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
              'Search By Category',
              style: GoogleFonts.yellowtail(
                color: global.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width * .9,
          child: ListView.separated(
            controller: widget.controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: global.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => CategoryPage(
                        userDoc: widget.userDoc,
                        initCategory: global.categories[index]['category'],
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Stack(
                      children: [
                        Center(
                          child: Image(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.width * .4,
                            image: AssetImage(
                              global.categories[index]['img'],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .4,
                            height: MediaQuery.of(context).size.height * .1,
                            color: const Color.fromRGBO(82, 82, 82, .5),
                            child: Center(
                              child: Text(
                                global.categories[index]['category'],
                                style: GoogleFonts.yellowtail(
                                  fontSize: 40,
                                  color: global.primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const VerticalDivider(),
          ),
        ),
      ],
    );
  }
}

// -------------------------- TABLET ------------------------- //

class SearchCategoryTabletWidget extends StatefulWidget {
  final ScrollController controller;
  const SearchCategoryTabletWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<SearchCategoryTabletWidget> createState() =>
      _SearchCategoryTabletWidgetState();
}

class _SearchCategoryTabletWidgetState
    extends State<SearchCategoryTabletWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
          width: MediaQuery.of(context).size.width * .6,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            child: Text(
              'Search By Category',
              style: GoogleFonts.yellowtail(
                color: global.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width * .65,
          child: ListView.separated(
            controller: widget.controller,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: global.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: MediaQuery.of(context).size.width * .2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Stack(
                    children: [
                      Center(
                        child: Image(
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.width * .2,
                          image: AssetImage(
                            global.categories[index]['img'],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .1,
                          color: const Color.fromRGBO(82, 82, 82, .5),
                          child: Center(
                            child: Text(
                              global.categories[index]['category'],
                              style: GoogleFonts.yellowtail(
                                fontSize: 40,
                                color: global.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const VerticalDivider(),
          ),
        ),
      ],
    );
  }
}
