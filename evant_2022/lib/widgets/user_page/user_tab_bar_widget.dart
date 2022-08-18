import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class UserTabBarWidget extends StatelessWidget {
  final int index;
  final void Function(int) updatePage;
  const UserTabBarWidget({
    Key? key,
    required this.index,
    required this.updatePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: UserTabBarMobileWidget(
        index: index,
        updatePage: updatePage,
      ),
    );
  }
}

// --------------------------------- MOBILE -----------------------------//

class UserTabBarMobileWidget extends StatelessWidget {
  final int index;
  final void Function(int) updatePage;
  const UserTabBarMobileWidget({
    Key? key,
    required this.index,
    required this.updatePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: global.secondaryColor,
        border: Border.all(
          color: global.secondaryColor,
          width: 5,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              updatePage(0);
            },
            child: Text(
              'Intro',
              style: TextStyle(
                color: (index == 0) ? global.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(1);
            },
            child: Text(
              'My Area',
              style: TextStyle(
                color: (index == 1) ? global.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(2);
            },
            child: Text(
              'People',
              style: TextStyle(
                color: (index == 2) ? global.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePage(3);
            },
            child: Text(
              'Events',
              style: TextStyle(
                color: (index == 3) ? global.primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
