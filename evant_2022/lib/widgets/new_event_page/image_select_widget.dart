import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class ImageSelectWidget extends StatefulWidget {
  final void Function(Uint8List) setImageFunction;
  final Uint8List newImage;
  const ImageSelectWidget({
    Key? key,
    required this.setImageFunction,
    required this.newImage,
  }) : super(key: key);

  @override
  State<ImageSelectWidget> createState() => _ImageSelectWidgetState();
}

class _ImageSelectWidgetState extends State<ImageSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: ImageSelectMobileWidget(
        setImageFunction: widget.setImageFunction,
        newImage: widget.newImage,
      ),
    );
  }
}

// --------------------------- MOBILE ------------------------

class ImageSelectMobileWidget extends StatefulWidget {
  final void Function(Uint8List) setImageFunction;
  final Uint8List newImage;
  const ImageSelectMobileWidget({
    Key? key,
    required this.setImageFunction,
    required this.newImage,
  }) : super(key: key);

  @override
  State<ImageSelectMobileWidget> createState() =>
      _ImageSelectMobileWidgetState();
}

class _ImageSelectMobileWidgetState extends State<ImageSelectMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final image = await ImagePickerWeb.getImageAsBytes();

          widget.setImageFunction(image!);
        } catch (e) {}
      },
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        width: MediaQuery.of(context).size.width * .8,
        decoration: BoxDecoration(
          border: Border.all(
            color: global.secondaryColor,
            width: 5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              20,
            ),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.memory(
                widget.newImage,
                fit: BoxFit.contain,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'click to add image',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
