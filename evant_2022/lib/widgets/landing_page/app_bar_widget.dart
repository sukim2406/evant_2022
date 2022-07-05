import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../responsive_layout_widget.dart';
import 'popup_menu_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/auth_controller.dart';

class AppBarWidget extends StatefulWidget {
  final String profileUrl;
  const AppBarWidget({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: AppBarMobileWidget(
        profileUrl: widget.profileUrl,
      ),
      // tabeltVer: AppBarTabletWidget(),
    );
  }
}

// --------------------------- MOBILE -------------------------- //

class AppBarMobileWidget extends StatefulWidget {
  final String profileUrl;
  const AppBarMobileWidget({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

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
          PopupMenuWidget(
            profileUrl: widget.profileUrl,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          ),
        ],
      ),
    );
  }
}

// ----------------------------  TABLET ----------------------- //

class AppBarTabletWidget extends StatefulWidget {
  final String profileUrl;
  const AppBarTabletWidget({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

  @override
  State<AppBarTabletWidget> createState() => _AppBarTabletWidgetState();
}

class _AppBarTabletWidgetState extends State<AppBarTabletWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      width: MediaQuery.of(context).size.width,
      child: Column(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  print('profile');
                },
                child: Text(
                  'Profile',
                  style: GoogleFonts.yellowtail(
                    color: global.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  AuthController.instance.logout();
                },
                child: Text(
                  'Log out',
                  style: GoogleFonts.yellowtail(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
