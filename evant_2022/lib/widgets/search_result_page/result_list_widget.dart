import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

class ResultListWidget extends StatefulWidget {
  const ResultListWidget({Key? key}) : super(key: key);

  @override
  State<ResultListWidget> createState() => _ResultListWidgetState();
}

class _ResultListWidgetState extends State<ResultListWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: ResultListMobileWidget(),
    );
  }
}

// ------------------------- MOBILE ------------------------- //

class ResultListMobileWidget extends StatefulWidget {
  const ResultListMobileWidget({Key? key}) : super(key: key);

  @override
  State<ResultListMobileWidget> createState() => _ResultListMobileWidgetState();
}

class _ResultListMobileWidgetState extends State<ResultListMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.grey,
    );
  }
}
