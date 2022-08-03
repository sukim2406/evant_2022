import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../controllers/global_controller.dart' as global;

class BottomBtnsWidget extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  const BottomBtnsWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
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
      ),
    );
  }
}

// ------------------------------- MOBILE ----------------------------- //

class BottomBtnsMobileWidget extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  const BottomBtnsMobileWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
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
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete event'),
                          content:
                              const Text('Do you want to delete this event?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                Navigator.pop(context);
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
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Save changes'),
                          content: const Text('Do you want to save Changes?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                Navigator.pop(context);
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
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Cancel RSVP'),
                            content:
                                const Text('Do you want to cancel your RSVP?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                                  Navigator.pop(context);
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
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('RSVP'),
                            content: const Text(
                                'Do you want to RSVP to this event?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
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
                                  Navigator.pop(context);
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
