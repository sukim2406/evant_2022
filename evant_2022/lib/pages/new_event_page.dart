import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/boxed_textfield_widget.dart';
import '../widgets/new_event_page/title_message_widget.dart';
import '../widgets/new_event_page/button_row_widget.dart';
import '../widgets/new_event_page/image_select_widget.dart';

import '../controllers/global_controller.dart' as global;

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
  late String? selectedStatus;
  late Uint8List newImage;
  bool imageSet = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController descriptionContoller = TextEditingController();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    23,
    59,
    59,
  );

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
    } else if (int.tryParse(maxController.text)! < 2) {
      errorString = 'Minimum participants must at least be 2';
      result = false;
    } else if (endTime.compareTo(startTime) < 0) {
      errorString = 'End time cannot be earlier then start time';
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

  void setStatus(status) {
    setState(() {
      selectedStatus = status;
    });
  }

  void setDefaultImage() async {
    final ByteData bytes = await rootBundle.load('img/event_default.png');
    setState(() {
      newImage = bytes.buffer.asUint8List();
      imageSet = true;
    });
  }

  void setStartTime(newStartTime) {
    setState(() {
      startTime = newStartTime;
    });
  }

  void setEndTime(newEndTime) {
    setState(
      () {
        endTime = newEndTime;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setDefaultImage();
    selectedCategory = global.categoryStrings[0];
    selectedStatus = global.statusStrings[0];
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
              startTime: startTime,
              setStartTime: setStartTime,
              endTime: endTime,
              setEndTime: setEndTime,
              setSelectedStatus: setStatus,
              selectedStatus: selectedStatus,
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
  final DateTime startTime;
  final DateTime endTime;
  final void Function(DateTime) setStartTime;
  final void Function(DateTime) setEndTime;
  final String? selectedStatus;
  final void Function(String) setSelectedStatus;
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
    required this.startTime,
    required this.endTime,
    required this.setStartTime,
    required this.setEndTime,
    required this.selectedStatus,
    required this.setSelectedStatus,
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
            const TitleMessageWidget(),
            ButtonRowWidget(
              checkEventInputs: widget.checkEventInputs,
              userDoc: widget.userDoc,
              point: widget.point,
              newImage: widget.newImage,
              startTime: widget.startTime,
              endTime: widget.endTime,
              titleController: widget.titleController,
              descriptionController: widget.descriptionContoller,
              maxController: widget.maxController,
              selectedCategory: widget.selectedCategory,
              selectedStatus: widget.selectedStatus,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .65,
              width: MediaQuery.of(context).size.width * .9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ImageSelectWidget(
                      setImageFunction: widget.setImageFunction,
                      newImage: widget.newImage,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
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
                          },
                        ),
                        const Expanded(
                          child: SizedBox(),
                        ),
                        const Text(
                          'Status :   ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DropdownButton<String>(
                          value: widget.selectedStatus,
                          items: global.statusStrings
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
                            widget.setSelectedStatus(item.toString());
                          },
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .05,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('Start Time'),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 12, 31),
                                  onConfirm: (date) {
                                    widget.setStartTime(date);
                                  },
                                );
                              },
                              child: BoxedTextFieldWidget(
                                hintText: 'Start Time',
                                width: MediaQuery.of(context).size.width * .3,
                                controller: TextEditingController(
                                  text: widget.startTime
                                      .toString()
                                      .substring(0, 19),
                                ),
                                obsecure: false,
                                focusNode: FocusNode(),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('End Time'),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDateTimePicker(
                                  context,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(2030, 12, 31),
                                  onConfirm: (date) {
                                    widget.setEndTime(date);
                                  },
                                );
                              },
                              child: BoxedTextFieldWidget(
                                hintText: 'End Time',
                                width: MediaQuery.of(context).size.width * .3,
                                controller: TextEditingController(
                                  text: widget.endTime
                                      .toString()
                                      .substring(0, 19),
                                ),
                                obsecure: false,
                                focusNode: FocusNode(),
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
