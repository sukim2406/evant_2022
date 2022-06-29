import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class BoxedTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double width;
  final bool obsecure;
  const BoxedTextFieldWidget({
    Key? key,
    required this.hintText,
    required this.width,
    required this.controller,
    required this.obsecure,
  }) : super(key: key);

  @override
  State<BoxedTextFieldWidget> createState() => _BoxedTextFieldWidgetState();
}

class _BoxedTextFieldWidgetState extends State<BoxedTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      debugLabel: 'Scope',
      autofocus: true,
      child: Focus(
        debugLabel: 'Focus',
        child: Builder(
          builder: (BuildContext context) {
            final FocusNode focusNode = Focus.of(context);
            final bool hasFocus = focusNode.hasFocus;
            return GestureDetector(
              onTap: () {
                if (hasFocus) {
                  focusNode.unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
              child: Container(
                width: widget.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color:
                        hasFocus ? global.primaryColor : global.secondaryColor,
                    width: 1,
                  ),
                  color:
                      hasFocus ? Colors.green.shade200 : Colors.grey.shade300,
                ),
                child: TextField(
                  controller: widget.controller,
                  obscureText: widget.obsecure,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    border: InputBorder.none,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
