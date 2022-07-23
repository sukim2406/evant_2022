import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class DropdownWidget extends StatefulWidget {
  final Function setSelectedCategory;
  final String selectedCategory;
  const DropdownWidget({
    Key? key,
    required this.selectedCategory,
    required this.setSelectedCategory,
  }) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: DropdownMobileWidget(
        selectedCategory: widget.selectedCategory,
        setSelectedCategory: widget.setSelectedCategory,
      ),
    );
  }
}

// -----------------------------  MOBILE ---------------------------

class DropdownMobileWidget extends StatefulWidget {
  final String selectedCategory;
  final Function setSelectedCategory;
  const DropdownMobileWidget({
    Key? key,
    required this.selectedCategory,
    required this.setSelectedCategory,
  }) : super(key: key);

  @override
  State<DropdownMobileWidget> createState() => _DropdownMobileWidgetState();
}

class _DropdownMobileWidgetState extends State<DropdownMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedCategory,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(
        color: global.primaryColor,
      ),
      underline: Container(
        height: 2,
        color: global.primaryColor,
      ),
      onChanged: (String? newCategory) {
        widget.setSelectedCategory(newCategory!);
      },
      items: global.categoryStrings.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
