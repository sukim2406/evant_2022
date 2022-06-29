import 'package:flutter/material.dart';

import '../controllers/global_controller.dart' as global;

class RoundedBtnWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback func;
  final String label;
  final Color btnColor;
  final Color txtColor;
  const RoundedBtnWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.func,
    required this.label,
    required this.btnColor,
    required this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: func,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            btnColor,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: txtColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
