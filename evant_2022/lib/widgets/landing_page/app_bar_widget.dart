import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive_layout_widget.dart';
import 'popup_menu_widget.dart';

import '../../controllers/global_controller.dart' as global;

class AppBarWidget extends StatefulWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: AppBarMobileWidget(),
    );
  }
}

// --------------------------- MOBILE -------------------------- //

class AppBarMobileWidget extends StatefulWidget {
  const AppBarMobileWidget({Key? key}) : super(key: key);

  @override
  State<AppBarMobileWidget> createState() => _AppBarMobileWidgetState();
}

class _AppBarMobileWidgetState extends State<AppBarMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .3,
            child: FittedBox(
              child: Text(
                'Evant',
                style: GoogleFonts.yellowtail(
                  textStyle: const TextStyle(
                    color: global.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          PopupMenuWidget(),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          ),
        ],
      ),
    );
  }
}
