import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class BoxedTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final bool obsecure;
  final FocusNode focusNode;
  final bool autoFocus;
  final bool enabled;
  final bool multiline;
  final double height;
  const BoxedTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.width,
    required this.controller,
    required this.obsecure,
    required this.focusNode,
    required this.enabled,
    this.multiline = false,
    this.autoFocus = false,
    this.height = 0,
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
      height: (widget.height != 0) ? widget.height : null,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(
          color: hasFocus ? global.primaryColor : global.secondaryColor,
          width: 1,
        ),
        color: hasFocus ? Colors.green.shade200 : Colors.grey.shade300,
      ),
      child: TextField(
        keyboardType: (widget.multiline) ? TextInputType.multiline : null,
        maxLines: (widget.multiline) ? 5 : 1,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
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
