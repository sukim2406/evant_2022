import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: FooterMobileWidget(),
      tabeltVer: FooterTabletWidget(),
    );
  }
}

// ------------------------ MOBILE ------------------------ //

class FooterMobileWidget extends StatelessWidget {
  const FooterMobileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .9,
      child: const Text(
        'developed by Soun Sean Kim\nssk.sosodev@gmail.com\ngithub.com/sukim2406/evant_2022',
        style: TextStyle(
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// -------------------- TABLET ----------------------------------//

class FooterTabletWidget extends StatelessWidget {
  const FooterTabletWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .05,
      width: MediaQuery.of(context).size.width * .9,
      child: const Text(
        'developed by Soun Sean Kim\nssk.sosodev@gmail.com\ngithub.com/sukim2406/evant_2022',
        style: TextStyle(
          fontSize: 10,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
