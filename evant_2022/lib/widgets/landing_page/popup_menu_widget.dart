import 'package:flutter/material.dart';

import '../responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/auth_controller.dart';

class PopupMenuWidget extends StatefulWidget {
  const PopupMenuWidget({Key? key}) : super(key: key);

  @override
  State<PopupMenuWidget> createState() => _PopupMenuWidgetState();
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: PopupMenuMobileWidget(),
    );
  }
}

// ------------------------ MOBILE -------------------------- //

class PopupMenuMobileWidget extends StatefulWidget {
  const PopupMenuMobileWidget({Key? key}) : super(key: key);

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
            print('profile');
          }
        },
        icon: CircleAvatar(
          radius: MediaQuery.of(context).size.height * .04,
          backgroundColor: global.primaryColor,
        ),
        iconSize: MediaQuery.of(context).size.height * .1,
      ),
    );
  }
}
