import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../controllers/global_controller.dart' as global;

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
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height * .1,
            backgroundColor: global.secondaryColor,
            backgroundImage: Image.network(
              widget.userDoc['profilePicture'],
              fit: BoxFit.contain,
            ).image,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          RoundedBtnWidget(
            height: null,
            width: null,
            func: () {
              print('hi');
            },
            label: 'Follow',
            btnColor: global.primaryColor,
            txtColor: Colors.black,
          )
        ],
      ),
    );
  }
}
