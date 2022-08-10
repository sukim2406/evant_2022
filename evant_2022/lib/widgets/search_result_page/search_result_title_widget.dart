import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class SearchResultTitleWidget extends StatelessWidget {
  final String keyword;
  const SearchResultTitleWidget({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: SearchResultTitleMobileWidget(
        keyword: keyword,
      ),
    );
  }
}

// -------------------- MOBILE --------------------- //

class SearchResultTitleMobileWidget extends StatelessWidget {
  final String keyword;
  const SearchResultTitleMobileWidget({
    Key? key,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .05,
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .5,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: RichText(
                text: TextSpan(
                  text: 'search result for \'',
                  style: const TextStyle(
                    color: global.secondaryColor,
                  ),
                  children: [
                    TextSpan(
                      text: keyword,
                      style: const TextStyle(
                        color: global.primaryColor,
                      ),
                    ),
                    const TextSpan(
                      text: '\'',
                      style: TextStyle(
                        color: global.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          )
        ],
      ),
    );
  }
}
