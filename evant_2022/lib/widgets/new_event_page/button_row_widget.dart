import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';
import '../../widgets/loading_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/storage_controller.dart';
import '../../controllers/event_controller.dart';
import '../../controllers/user_controller.dart';

import '../../pages/landing_page.dart';

class ButtonRowWidget extends StatefulWidget {
  final bool Function() checkEventInputs;
  final Map userDoc;
  final LatLng point;
  final Uint8List newImage;
  final DateTime startTime;
  final DateTime endTime;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController maxController;
  final String? selectedCategory;
  final String? selectedStatus;
  const ButtonRowWidget({
    Key? key,
    required this.checkEventInputs,
    required this.userDoc,
    required this.point,
    required this.newImage,
    required this.startTime,
    required this.endTime,
    required this.titleController,
    required this.descriptionController,
    required this.maxController,
    required this.selectedCategory,
    required this.selectedStatus,
  }) : super(key: key);

  @override
  State<ButtonRowWidget> createState() => _ButtonRowWidgetState();
}

class _ButtonRowWidgetState extends State<ButtonRowWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: ButtonRowMobileWidget(
        checkEventInputs: widget.checkEventInputs,
        userDoc: widget.userDoc,
        point: widget.point,
        newImage: widget.newImage,
        startTime: widget.startTime,
        endTime: widget.endTime,
        titleController: widget.titleController,
        descriptionController: widget.descriptionController,
        maxController: widget.maxController,
        selectedCategory: widget.selectedCategory,
        selectedStatus: widget.selectedStatus,
      ),
    );
  }
}

// ------------------------------ MOBILE -----------------------------

class ButtonRowMobileWidget extends StatefulWidget {
  final bool Function() checkEventInputs;
  final Map userDoc;
  final LatLng point;
  final Uint8List newImage;
  final DateTime startTime;
  final DateTime endTime;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController maxController;
  final String? selectedCategory;
  final String? selectedStatus;
  const ButtonRowMobileWidget({
    Key? key,
    required this.checkEventInputs,
    required this.userDoc,
    required this.point,
    required this.newImage,
    required this.startTime,
    required this.endTime,
    required this.titleController,
    required this.descriptionController,
    required this.maxController,
    required this.selectedCategory,
    required this.selectedStatus,
  }) : super(key: key);

  @override
  State<ButtonRowMobileWidget> createState() => _ButtonRowMobileWidgetState();
}

class _ButtonRowMobileWidgetState extends State<ButtonRowMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoadingWidget(),
                ),
              );
              final inputCheck = widget.checkEventInputs();
              if (inputCheck) {
                String eventId =
                    '${widget.userDoc['email']}-${widget.point.latitude}-${widget.point.longitude}';
                String eventImage = '';

                StorageController.instance
                    .uploadEventImage(eventId, widget.newImage)
                    .then((result) {
                  if (result) {
                    StorageController.instance
                        .getEventImageUrl(eventId)
                        .then((url) {
                      if (url == '') {
                        Navigator.pop(context);
                        print('getEventImageUrl error');
                        Get.snackbar(
                          'getEventImageUrl error',
                          'getEventImageUrl error',
                          backgroundColor: Colors.redAccent,
                          snackPosition: SnackPosition.BOTTOM,
                          titleText: const Text(
                            'getEventImageUrl error',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        eventImage = url;
                        final eventData = {
                          'host': widget.userDoc['uid'],
                          'id': eventId,
                          'location': {
                            'lat': widget.point.latitude,
                            'lng': widget.point.longitude,
                          },
                          'time': {
                            'start': widget.startTime,
                            'end': widget.endTime,
                          },
                          'title': widget.titleController.text,
                          'description': widget.descriptionController.text,
                          'category': widget.selectedCategory,
                          'max': widget.maxController.text,
                          'rsvpList': [
                            widget.userDoc['uid'],
                          ],
                          'eventImage': eventImage,
                          'open': true,
                          'status': widget.selectedStatus,
                        };
                        EventController.instance
                            .createEventDoc(eventData)
                            .then((result) async {
                          if (result) {
                            UserController.instance
                                .updateMyEvent(
                              widget.userDoc['uid'],
                              eventData['id'],
                            )
                                .then((result) {
                              if (result) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LandingPage(),
                                  ),
                                  (route) => false,
                                );
                              } else {
                                Navigator.pop(context);
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
                            Navigator.pop(context);
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
                    });
                  } else {
                    Navigator.pop(context);
                    print('error');
                    Get.snackbar(
                      'uploadEventImage error',
                      'uploadEventImage error',
                      backgroundColor: Colors.redAccent,
                      snackPosition: SnackPosition.BOTTOM,
                      titleText: const Text(
                        'uploadEventImage error',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                });
              } else {
                Navigator.pop(context);
              }
            },
            label: 'CREATE',
            btnColor: global.primaryColor,
            txtColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
