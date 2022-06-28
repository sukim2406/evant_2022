import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class ResponsiveLayoutWidget extends StatelessWidget {
  final Widget mobileVer;
  final Widget? tabeltVer;
  final Widget? desktopVer;
  const ResponsiveLayoutWidget({
    Key? key,
    required this.mobileVer,
    this.tabeltVer,
    this.desktopVer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        if (constraints.maxWidth < global.kTabletBreakPoint) {
          return mobileVer;
        } else if (constraints.maxWidth >= global.kTabletBreakPoint &&
            constraints.maxWidth < global.kDesktopBreakPoint) {
          return tabeltVer ?? mobileVer;
        } else {
          return desktopVer ?? tabeltVer ?? mobileVer;
        }
      }),
    );
  }
}
