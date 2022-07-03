import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';

class SearchCategoryWidget extends StatefulWidget {
  const SearchCategoryWidget({Key? key}) : super(key: key);

  @override
  State<SearchCategoryWidget> createState() => _SearchCategoryWidgetState();
}

class _SearchCategoryWidgetState extends State<SearchCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: SearchCategoryMobileWidget(),
    );
  }
}

// --------------------------- MOBILE ------------------------ //

class SearchCategoryMobileWidget extends StatefulWidget {
  const SearchCategoryMobileWidget({
    Key? key,
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
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: global.categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
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