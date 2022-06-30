import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class BoxedTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final bool obsecure;
  final FocusNode focusNode;
  final bool autoFocus;
  const BoxedTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.width,
    required this.controller,
    required this.obsecure,
    required this.focusNode,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  State<BoxedTextFieldWidget> createState() => _BoxedTextFieldWidgetState();
}

class _BoxedTextFieldWidgetState extends State<BoxedTextFieldWidget> {
  late bool hasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      if (mounted) {
        setState(() {
          hasFocus = widget.focusNode.hasFocus;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: hasFocus ? global.primaryColor : global.secondaryColor,
          width: 1,
        ),
        color: hasFocus ? Colors.green.shade200 : Colors.grey.shade300,
      ),
      child: TextField(
        focusNode: widget.focusNode,
        autofocus: (widget.autoFocus) ? true : false,
        controller: widget.controller,
        obscureText: widget.obsecure,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
