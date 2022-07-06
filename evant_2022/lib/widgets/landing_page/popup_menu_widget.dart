import 'package:flutter/material.dart';

import '../responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/auth_controller.dart';

import '../../pages/profile_page.dart';
import '../../pages/landing_page.dart';

class PopupMenuWidget extends StatefulWidget {
  final String profileUrl;
  const PopupMenuWidget({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

  @override
  State<PopupMenuWidget> createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: PopupMenuMobileWidget(
        profileUrl: widget.profileUrl,
      ),
    );
  }
}

// ------------------------ MOBILE -------------------------- //

class PopupMenuMobileWidget extends StatefulWidget {
  final String profileUrl;
  const PopupMenuMobileWidget({
    Key? key,
    required this.profileUrl,
  }) : super(key: key);

  @override
  State<PopupMenuMobileWidget> createState() => _PopupMenuMobileWidgetState();
}

class _PopupMenuMobileWidgetState extends State<PopupMenuMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height * .1,
      height: MediaQuery.of(context).size.height * .1,
      child: PopupMenuButton(
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem(
            value: 2,
            child: Text(
              'Home',
            ),
          ),
          const PopupMenuItem(
            value: 1,
            child: Text(
              'Profile',
            ),
          ),
          const PopupMenuItem(
            value: 0,
            child: Text('Log out'),
          ),
        ],
        onSelected: (result) {
          if (result == 0) {
            AuthController.instance.logout();
          } else if (result == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const ProfilePage(),
              ),
              (route) => false,
            );
          } else if (result == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LandingPage(),
              ),
              (route) => false,
            );
          }
        },
        icon: CircleAvatar(
          radius: MediaQuery.of(context).size.height * .04,
          backgroundColor: Colors.white,
          backgroundImage: Image.network(
            widget.profileUrl,
            fit: BoxFit.contain,
          ).image,
        ),
        iconSize: MediaQuery.of(context).size.height * .1,
      ),
    );
  }
}
