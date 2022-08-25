import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';
import '../../widgets/boxed_textfield_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/user_controller.dart';

class UserInfoWidget extends StatefulWidget {
  final Map myUserDoc;
  final Map userDoc;
  const UserInfoWidget({
    Key? key,
    required this.myUserDoc,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<UserInfoWidget> createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  bool following = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.myUserDoc['following'].contains(widget.userDoc['uid'])) {
    //   setState(() {
    //     following = true;
    //   });
    // }
    checkFollowing();
  }

  void checkFollowing() {
    UserController.instance
        .getFollowingList(widget.myUserDoc['uid'])
        .then((result) {
      if (result.contains(widget.userDoc['uid'])) {
        setState(() {
          following = true;
        });
      } else {
        setState(() {
          following = false;
        });
      }
    });
  }

  void refreshPage() {
    checkFollowing();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
        mobileVer: UserInfoMobileWidget(
      userDoc: widget.userDoc,
      following: following,
      myUserDoc: widget.myUserDoc,
      refreshPage: refreshPage,
    ));
  }
}

// ------------------------- MOBILE ----------------------------- //

class UserInfoMobileWidget extends StatefulWidget {
  final Map myUserDoc;
  final bool following;
  final Map userDoc;
  final VoidCallback refreshPage;
  const UserInfoMobileWidget({
    Key? key,
    required this.userDoc,
    required this.following,
    required this.myUserDoc,
    required this.refreshPage,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .08,
            width: MediaQuery.of(context).size.width * .4,
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Text(
                widget.userDoc['screenName'],
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          RoundedBtnWidget(
            height: null,
            width: null,
            func: () {
              UserController.instance
                  .updateFollowingList(
                widget.myUserDoc['uid'],
                widget.userDoc['uid'],
                widget.following,
              )
                  .then((result) {
                print('hi');
                widget.refreshPage();
              });
            },
            label: (widget.following) ? 'Unfollow' : 'Follow',
            btnColor: (widget.following)
                ? global.secondaryColor
                : global.primaryColor,
            txtColor: Colors.black,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          BoxedTextFieldWidget(
            hintText: 'Greet Message',
            width: MediaQuery.of(context).size.width * .7,
            controller: TextEditingController(text: widget.userDoc['greetMsg']),
            obsecure: false,
            focusNode: FocusNode(),
            enabled: false,
            multiline: true,
          ),
        ],
      ),
    );
  }
}
