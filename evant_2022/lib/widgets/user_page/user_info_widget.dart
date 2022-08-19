import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

class UserInfoWidget extends StatefulWidget {
  final Map userDoc;
  const UserInfoWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
        mobileVer: UserInfoMobileWidget(
      userDoc: widget.userDoc,
    ));
  }
}

// ------------------------- MOBILE ----------------------------- //

class UserInfoMobileWidget extends StatefulWidget {
  final Map userDoc;
  const UserInfoMobileWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<UserInfoMobileWidget> createState() => _UserInfoMobileWidgetState();
}

class _UserInfoMobileWidgetState extends State<UserInfoMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.red,
    );
  }
}
