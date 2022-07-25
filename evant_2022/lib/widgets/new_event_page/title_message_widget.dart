import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class TitleMessageWidget extends StatelessWidget {
  const TitleMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: TitleMessageMobileWidget(),
    );
  }
}

// ----------------------------- MOBILE ----------------------------

class TitleMessageMobileWidget extends StatelessWidget {
  const TitleMessageMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .05,
      width: MediaQuery.of(context).size.width * .9,
      child: FittedBox(
        child: Text(
          'Create a New Event',
          style: GoogleFonts.yellowtail(
            color: global.secondaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
