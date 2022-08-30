import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class UserFollowWidget extends StatefulWidget {
  const UserFollowWidget({Key? key}) : super(key: key);

  @override
  State<UserFollowWidget> createState() => _UserFollowWidgetState();
}

class _UserFollowWidgetState extends State<UserFollowWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(mobileVer: UserFollowMobileWidget());
  }
}

// ------------------------ MOBILE ---------------------- //

class UserFollowMobileWidget extends StatefulWidget {
  const UserFollowMobileWidget({Key? key}) : super(key: key);

  @override
  State<UserFollowMobileWidget> createState() => _UserFollowMobileWidgetState();
}

class _UserFollowMobileWidgetState extends State<UserFollowMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: global.secondaryColor,
        border: Border.all(
          color: global.secondaryColor,
          width: 5,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width * .9,
            color: Colors.red,
          ),
          Container(
            height: MediaQuery.of(context).size.height * .35,
            width: MediaQuery.of(context).size.width * .9,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
