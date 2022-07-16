import 'dart:html';

import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../controllers/event_controller.dart';
import '../../controllers/user_controller.dart';
import '../../controllers/global_controller.dart' as global;

import '../../pages/landing_page.dart';

class BottomAppBarWidget extends StatelessWidget {
  final Map userDoc;
  final Map eventData;
  final Function() amIHost;
  final Function() isEventFull;
  final Function() amIAttending;
  const BottomAppBarWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
    required this.amIHost,
    required this.isEventFull,
    required this.amIAttending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
        mobileVer: BottomAppBarMobileWidget(
      userDoc: userDoc,
      eventData: eventData,
      amIHost: amIHost,
      isEventFull: isEventFull,
      amIAttending: amIAttending,
    ));
  }
}

// ------------------------ MOBILE ---------------------------- //

class BottomAppBarMobileWidget extends StatelessWidget {
  final Map userDoc;
  final Map eventData;
  final Function() amIHost;
  final Function() isEventFull;
  final Function() amIAttending;
  const BottomAppBarMobileWidget({
    Key? key,
    required this.eventData,
    required this.userDoc,
    required this.amIHost,
    required this.isEventFull,
    required this.amIAttending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .05,
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          (amIHost())
              ? RoundedBtnWidget(
                  height: null,
                  width: null,
                  func: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Cancel this event ? '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: global.secondaryColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await UserController.instance
                                  .cancelEvent(
                                eventData['id'],
                                eventData['rsvpList'],
                              )
                                  .then((result) async {
                                await EventController.instance
                                    .deleteEvent(eventData['id'])
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
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  label: 'CANCEL EVENT',
                  btnColor: global.secondaryColor,
                  txtColor: Colors.white,
                )
              : Container(),
          SizedBox(
            width: MediaQuery.of(context).size.width * .05,
          ),
          (amIHost())
              ? RoundedBtnWidget(
                  height: null,
                  width: null,
                  func: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Close this event ?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: global.secondaryColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await EventController.instance
                                  .closeEvent(eventData['id'])
                                  .then(
                                (result) async {
                                  print(
                                      'event_detail_page closeEvent result $result');
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
                                    print('closeEvent error');
                                  }
                                },
                              );
                            },
                            child: const Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  label: 'CLOSE EVENT',
                  btnColor: Colors.redAccent,
                  txtColor: Colors.white,
                )
              : (amIAttending())
                  ? RoundedBtnWidget(
                      height: null,
                      width: null,
                      func: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Cancel RSVP for this event ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'back',
                                  style:
                                      TextStyle(color: global.secondaryColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  EventController.instance
                                      .updateEventRSVP(userDoc, eventData)
                                      .then(
                                    (updateEventRSVPResult) {
                                      if (updateEventRSVPResult) {
                                        UserController.instance
                                            .updateMyEvent(
                                          userDoc['uid'],
                                          eventData['id'],
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
                                            print('updateMyEvent error');
                                          }
                                        });
                                      } else {
                                        print('updateEventRSVP error');
                                      }
                                    },
                                  );
                                },
                                child: const Text(
                                  'Cancel RSVP',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      label: 'Cancel RSVP',
                      btnColor: global.secondaryColor,
                      txtColor: Colors.white,
                    )
                  : (isEventFull())
                      ? RoundedBtnWidget(
                          height: null,
                          width: null,
                          func: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Sorry, Event is full',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(
                                        color: global.secondaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          label: 'JOIN EVENT',
                          btnColor: Colors.grey,
                          txtColor: Colors.white,
                        )
                      : RoundedBtnWidget(
                          height: null,
                          width: null,
                          func: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Join this event ?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: global.secondaryColor),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      EventController.instance
                                          .updateEventRSVP(userDoc, eventData)
                                          .then(
                                        (updateEventRSVPResult) {
                                          if (updateEventRSVPResult) {
                                            UserController.instance
                                                .updateMyEvent(
                                              userDoc['uid'],
                                              eventData['id'],
                                            )
                                                .then((updateMyEventResult) {
                                              if (updateMyEventResult) {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        const LandingPage(),
                                                  ),
                                                  (route) => false,
                                                );
                                              } else {
                                                print('updateMyEvent error');
                                              }
                                            });
                                          } else {
                                            print('updateEventRSVP error');
                                          }
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'JOIN',
                                      style: TextStyle(
                                        color: global.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          label: 'JOIN EVENT',
                          btnColor: global.primaryColor,
                          txtColor: Colors.white,
                        ),
        ],
      ),
    );
  }
}
