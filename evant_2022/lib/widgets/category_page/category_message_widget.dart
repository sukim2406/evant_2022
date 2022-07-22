import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class CategoryMessageWidget extends StatelessWidget {
  const CategoryMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: CategoryMessageMobileWidget(),
    );
  }
}

//-----------------------  MOBILE -------------------------- //

class CategoryMessageMobileWidget extends StatelessWidget {
  const CategoryMessageMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width * .5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .5,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Looking for Specific Type ? ',
                style: GoogleFonts.yellowtail(
                  color: global.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .025,
            width: MediaQuery.of(context).size.width * .5,
            child: const FittedBox(
              alignment: Alignment.centerLeft,
              child: Text(
                'Search events by category !',
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
