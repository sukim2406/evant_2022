import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/event_controller.dart';
import '../../controllers/user_controller.dart';

import '../../pages/landing_page.dart';

class BottomBtnsWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final TextEditingController attendanceController;
  final TextEditingController maxController;
  final TextEditingController statusController;
  final DateTime startTime;
  final DateTime endTime;
  final Map userDoc;
  final Map eventData;
  const BottomBtnsWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
    required this.titleController,
    required this.attendanceController,
    required this.categoryController,
    required this.descriptionController,
    required this.maxController,
    required this.statusController,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  State<BottomBtnsWidget> createState() => _BottomBtnsWidgetState();
}

class _BottomBtnsWidgetState extends State<BottomBtnsWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: BottomBtnsMobileWidget(
        userDoc: widget.userDoc,
        eventData: widget.eventData,
        descriptionController: widget.descriptionController,
        categoryController: widget.categoryController,
        attendanceController: widget.attendanceController,
        maxController: widget.maxController,
        statusController: widget.statusController,
        titleController: widget.titleController,
        startTime: widget.startTime,
        endTime: widget.endTime,
      ),
    );
  }
}

// ------------------------------- MOBILE ----------------------------- //

class BottomBtnsMobileWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final TextEditingController attendanceController;
  final TextEditingController maxController;
  final TextEditingController statusController;
  final DateTime startTime;
  final DateTime endTime;
  final Map userDoc;
  final Map eventData;
  const BottomBtnsMobileWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
    required this.titleController,
    required this.attendanceController,
    required this.categoryController,
    required this.descriptionController,
    required this.maxController,
    required this.statusController,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  State<BottomBtnsMobileWidget> createState() => _BottomBtnsMobileWidgetState();
}

class _BottomBtnsMobileWidgetState extends State<BottomBtnsMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      child: (widget.eventData['host'] == widget.userDoc['uid'])
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: null,
                  func: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Delete event'),
                          content:
                              const Text('Do you want to delete this event?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                UserController.instance
                                    .cancelEvent(
                                  widget.eventData['id'],
                                  widget.eventData['rsvpList'],
                                )
                                    .then((result) async {
                                  await EventController.instance
                                      .deleteEvent(widget.eventData['id'])
                                      .then((deleteEventResult) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const LandingPage(),
                                      ),
                                      (route) => false,
                                    );
                                  });
                                });
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  label: 'Cancel event',
                  btnColor: Colors.redAccent,
                  txtColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: null,
                  func: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('Save changes'),
                          content: const Text('Do you want to save Changes?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (widget.titleController.text.isEmpty) {
                                  Get.snackbar(
                                    'Title Error',
                                    'Title cannot be empty',
                                    backgroundColor: Colors.redAccent,
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: const Text(
                                      'Title Error',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else if (widget.eventData['rsvpList'].length >
                                    int.parse(widget.maxController.text)) {
                                  Get.snackbar(
                                    'Max Attendance Error',
                                    'Max attendance cannot be smaller then current attendance',
                                    backgroundColor: Colors.redAccent,
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: const Text(
                                      'Max Attendance Error',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else if (widget.startTime
                                        .compareTo(widget.endTime) >
                                    0) {
                                  Get.snackbar(
                                    'Event Time Error',
                                    'Start time cannot be later then end time',
                                    backgroundColor: Colors.redAccent,
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: const Text(
                                      'Event Time Error',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                } else {
                                  EventController.instance
                                      .updateEvent(
                                    widget.eventData['id'],
                                    widget.titleController.text,
                                    widget.descriptionController.text,
                                    widget.categoryController.text,
                                    widget.maxController.text,
                                    widget.statusController.text,
                                    widget.startTime,
                                    widget.endTime,
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
                                      Get.snackbar(
                                        'Event Update Error',
                                        'Event update was unsuccessful',
                                        backgroundColor: Colors.redAccent,
                                        snackPosition: SnackPosition.BOTTOM,
                                        titleText: const Text(
                                          'Event Update Error',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
                                Navigator.pop(dialogContext);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: global.primaryColor,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                  label: 'Save Changes',
                  btnColor: global.primaryColor,
                  txtColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
              ],
            )
          : Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: null,
                  func: () {
                    if (widget.eventData['rsvpList']
                        .contains(widget.userDoc['uid'])) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text('Cancel RSVP'),
                            content:
                                const Text('Do you want to cancel your RSVP?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text(
                                  'no',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  EventController.instance
                                      .updateEventRSVP(
                                          widget.userDoc, widget.eventData)
                                      .then(
                                    (updateEventRSVPResult) {
                                      if (updateEventRSVPResult) {
                                        UserController.instance
                                            .updateMyEvent(
                                          widget.userDoc['uid'],
                                          widget.eventData['id'],
                                        )
                                            .then((updateMyEventResult) {
                                          if (updateMyEventResult) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LandingPage(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            Get.snackbar(
                                              'updateMyEvent Error',
                                              'Event update was unsuccessful',
                                              backgroundColor: Colors.redAccent,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              titleText: const Text(
                                                'updateMyEvent Error',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                            print('updateMyEvent error');
                                          }
                                        });
                                      } else {
                                        Get.snackbar(
                                          'updateEventRSVP Error',
                                          'Event update was unsuccessful',
                                          backgroundColor: Colors.redAccent,
                                          snackPosition: SnackPosition.BOTTOM,
                                          titleText: const Text(
                                            'updateEventRSVP Error',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                        print('updateEventRSVP error');
                                      }
                                    },
                                  );
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text(
                                  'Cancel RSVP',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text('RSVP'),
                            content: const Text(
                                'Do you want to RSVP to this event?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  EventController.instance
                                      .updateEventRSVP(
                                          widget.userDoc, widget.eventData)
                                      .then(
                                    (updateEventRSVPResult) {
                                      if (updateEventRSVPResult) {
                                        UserController.instance
                                            .updateMyEvent(
                                          widget.userDoc['uid'],
                                          widget.eventData['id'],
                                        )
                                            .then((updateMyEventResult) {
                                          if (updateMyEventResult) {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        const LandingPage(),
                                              ),
                                              (route) => false,
                                            );
                                          } else {
                                            Get.snackbar(
                                              'updateMyEvent Error',
                                              'Event update was unsuccessful',
                                              backgroundColor: Colors.redAccent,
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              titleText: const Text(
                                                'updateMyEvent Error',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                            print('updateMyEvent error');
                                          }
                                        });
                                      } else {
                                        Get.snackbar(
                                          'updateEventRSVP Error',
                                          'Event update was unsuccessful',
                                          backgroundColor: Colors.redAccent,
                                          snackPosition: SnackPosition.BOTTOM,
                                          titleText: const Text(
                                            'updateEventRSVP Error',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        );
                                        print('updateEventRSVP error');
                                      }
                                    },
                                  );
                                  Navigator.pop(dialogContext);
                                },
                                child: const Text(
                                  'Attend',
                                  style: TextStyle(
                                    color: global.primaryColor,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }
                  },
                  label: (widget.eventData['rsvpList']
                          .contains(widget.userDoc['uid']))
                      ? 'cancel RSVP'
                      : 'RSVP',
                  btnColor: (widget.eventData['rsvpList']
                          .contains(widget.userDoc['uid']))
                      ? global.secondaryColor
                      : global.primaryColor,
                  txtColor: Colors.white,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
              ],
            ),
    );
  }
}
