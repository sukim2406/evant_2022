import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

class CreateButtonWidget extends StatelessWidget {
  const CreateButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: CreateButtonMobileWidget(),
    );
  }
}

// --------------------- MOBILE ----------------------- //

class CreateButtonMobileWidget extends StatefulWidget {
  const CreateButtonMobileWidget({Key? key}) : super(key: key);

  @override
  State<CreateButtonMobileWidget> createState() =>
      _CreateButtonMobileWidgetState();
}

class _CreateButtonMobileWidgetState extends State<CreateButtonMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.grey,
    );
  }
}
