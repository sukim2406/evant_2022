import 'package:flutter/material.dart';

import '../responsive_layout_widget.dart';

class CategoryTableWidget extends StatefulWidget {
  const CategoryTableWidget({Key? key}) : super(key: key);

  @override
  State<CategoryTableWidget> createState() => _CategoryTableWidgetState();
}

class _CategoryTableWidgetState extends State<CategoryTableWidget> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayoutWidget(
      mobileVer: CategoryTableMobileWidget(),
    );
  }
}

// -------------------------- MOBILE ------------------------- //

class CategoryTableMobileWidget extends StatefulWidget {
  const CategoryTableMobileWidget({Key? key}) : super(key: key);

  @override
  State<CategoryTableMobileWidget> createState() =>
      _CategoryTableMobileWidgetState();
}

class _CategoryTableMobileWidgetState extends State<CategoryTableMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .55,
      width: MediaQuery.of(context).size.width * .9,
      color: Colors.grey,
    );
  }
}
