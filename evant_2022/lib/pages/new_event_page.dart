import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker_web/image_picker_web.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/boxed_textfield_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/user_controller.dart';
import '../controllers/event_controller.dart';

class NewEventPage extends StatefulWidget {
  final Map userDoc;
  final LatLng point;
  const NewEventPage({
    Key? key,
    required this.userDoc,
    required this.point,
  }) : super(key: key);

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  late String? selectedCategory;
  late Uint8List newImage;
  bool imageSet = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController descriptionContoller = TextEditingController();

  bool checkEventInputs() {
    bool result;
    String errorString = '';
    if (titleController.text.isEmpty) {
      errorString = 'Title can not be empty';
      result = false;
    } else if (maxController.text.isEmpty) {
      errorString = 'Please enter maximum number of participants';
      result = false;
    } else if (int.tryParse(maxController.text) == null) {
      errorString = 'Please enter integer as maximum number of participants';
      result = false;
    } else {
      result = true;
    }
    if (result) {
      return result;
    } else {
      Get.snackbar(
        'checkEventInput error',
        errorString,
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          errorString,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      );
      return result;
    }
  }

  void setImage(image) {
    setState(() {
      newImage = image;
      imageSet = true;
    });
  }

  void setCategory(category) {
    setState(
      () {
        selectedCategory = category;
      },
    );
  }

  void setDefaultImage() async {
    final ByteData bytes = await rootBundle.load('img/event_default.png');
    setState(() {
      newImage = bytes.buffer.asUint8List();
      imageSet = true;
    });
  }

  @override
  void initState() {
    super.initState();
    setDefaultImage();
    selectedCategory = global.categoryStrings[0];
  }

  @override
  Widget build(BuildContext context) {
    return (imageSet)
        ? ResponsiveLayoutWidget(
            mobileVer: NewEventMobilePage(
              userDoc: widget.userDoc,
              point: widget.point,
              newImage: newImage,
              imageSet: imageSet,
              setImageFunction: setImage,
              titleController: titleController,
              maxController: maxController,
              descriptionContoller: descriptionContoller,
              selectedCategory: selectedCategory,
              setSelectedCategory: setCategory,
              checkEventInputs: checkEventInputs,
            ),
          )
        : const LoadingWidget();
  }
}

// ---------------------------- MOBILE ------------------------ //

class NewEventMobilePage extends StatefulWidget {
  final bool Function() checkEventInputs;
  final void Function(String) setSelectedCategory;
  final void Function(Uint8List) setImageFunction;
  final Uint8List newImage;
  final bool imageSet;
  final Map userDoc;
  final LatLng point;
  final TextEditingController titleController;
  final TextEditingController maxController;
  final TextEditingController descriptionContoller;
  final String? selectedCategory;
  const NewEventMobilePage({
    Key? key,
    required this.checkEventInputs,
    required this.userDoc,
    required this.point,
    required this.newImage,
    required this.imageSet,
    required this.setImageFunction,
    required this.titleController,
    required this.maxController,
    required this.descriptionContoller,
    required this.selectedCategory,
    required this.setSelectedCategory,
  }) : super(key: key);

  @override
  State<NewEventMobilePage> createState() => _NewEventMobilePageState();
}

class _NewEventMobilePageState extends State<NewEventMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            AppBarWidget(profileUrl: widget.userDoc['profilePicture']),
            SizedBox(
              height: MediaQuery.of(context).size.height * .05,
              width: MediaQuery.of(context).size.width * .9,
              child: FittedBox(
                child: Text('Create a New Event',
                    style: GoogleFonts.yellowtail(
                      color: global.secondaryColor,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedBtnWidget(
                    height: null,
                    width: MediaQuery.of(context).size.width * .2,
                    func: () {
                      Navigator.pop(context);
                    },
                    label: 'CANCEL',
                    btnColor: global.secondaryColor,
                    txtColor: Colors.white,
                  ),
                  RoundedBtnWidget(
                    height: null,
                    width: MediaQuery.of(context).size.width * .2,
                    func: () {
                      final inputCheck = widget.checkEventInputs();
                      if (inputCheck) {
                        final eventData = {
                          'host': widget.userDoc['uid'],
                          'id': '${widget.userDoc['uid']}-${DateTime.now()}',
                          'lat': widget.point.latitude,
                          'lng': widget.point.longitude,
                          'title': widget.titleController.text,
                          'description': widget.descriptionContoller.text,
                          'category': widget.selectedCategory,
                          'max': widget.maxController.text,
                        };
                        EventController.instance
                            .createEventDoc(eventData)
                            .then((result) async {
                          if (result) {
                            UserController.instance
                                .updateMyEvent(
                              eventData['host'],
                              eventData['id'],
                            )
                                .then((result) {
                              if (result) {
                                print('success');
                              } else {
                                Get.snackbar(
                                  'updateMyEvent error',
                                  'updateMyEvent error',
                                  backgroundColor: Colors.redAccent,
                                  snackPosition: SnackPosition.BOTTOM,
                                  titleText: const Text(
                                    'updateMyEvent error',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            });
                          } else {
                            Get.snackbar(
                              'createEventDoc error',
                              'createEventDoc error',
                              backgroundColor: Colors.redAccent,
                              snackPosition: SnackPosition.BOTTOM,
                              titleText: const Text(
                                'createEventDoc error',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }
                        });
                      }
                    },
                    label: 'CREATE',
                    btnColor: global.primaryColor,
                    txtColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .65,
              width: MediaQuery.of(context).size.width * .9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final image = await ImagePickerWeb.getImageAsBytes();

                        widget.setImageFunction(image!);
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
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    BoxedTextFieldWidget(
                      hintText: 'title',
                      width: MediaQuery.of(context).size.width * .8,
                      controller: widget.titleController,
                      obsecure: false,
                      focusNode: FocusNode(),
                      enabled: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    BoxedTextFieldWidget(
                      hintText: 'description',
                      width: MediaQuery.of(context).size.width * .8,
                      controller: widget.descriptionContoller,
                      obsecure: false,
                      focusNode: FocusNode(),
                      enabled: true,
                      multiline: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    BoxedTextFieldWidget(
                      hintText: 'max participants',
                      width: MediaQuery.of(context).size.width * .8,
                      controller: widget.maxController,
                      obsecure: false,
                      focusNode: FocusNode(),
                      enabled: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Category :   ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                            value: widget.selectedCategory,
                            items: global.categoryStrings
                                .map(
                                  (item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (item) {
                              widget.setSelectedCategory(item.toString());
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}