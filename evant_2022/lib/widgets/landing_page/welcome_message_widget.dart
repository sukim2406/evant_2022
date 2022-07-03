import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: WelcomeMessageMobileWidget(),
      tabeltVer: WelcomeMessageTabletWidget(),
    );
  }
}

// ------------------------- MOBILE ----------------- //

class WelcomeMessageMobileWidget extends StatelessWidget {
  const WelcomeMessageMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .9,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bored ? Want to gather up ?',
                style: GoogleFonts.yellowtail(
                  textStyle: const TextStyle(
                    color: global.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
            width: MediaQuery.of(context).size.width * .9,
            child: const FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Find events near you, or create one yourself and share with others!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------- TABLET ---------------------- //
class WelcomeMessageTabletWidget extends StatelessWidget {
  const WelcomeMessageTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .6,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Bored ? Want to gather up ?',
                style: GoogleFonts.yellowtail(
                  textStyle: const TextStyle(
                    color: global.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
            width: MediaQuery.of(context).size.width * .6,
            child: const FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Find events near you, or create one yourself and share with others!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
