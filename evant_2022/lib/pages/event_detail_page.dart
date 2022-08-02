import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/event_detail_page/attendance_widget.dart';
import '../widgets/event_detail_page/event_map_widget.dart';
import '../widgets/event_detail_page/bottom_app_bar.dart';
import '../widgets/event_detail_page/event_details_widget.dart';
import '../widgets/event_detail_page/bottom_btns_widget.dart';

import '../controllers/global_controller.dart' as global;
import '../controllers/event_controller.dart';
import '../controllers/user_controller.dart';

import '../pages/landing_page.dart';

class EventDetailPage extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  const EventDetailPage({
    Key? key,
    required this.eventData,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool amIHost() {
    bool result = false;

    if (widget.userDoc['uid'] == widget.eventData['host']) {
      result = true;
    }

    return result;
  }

  bool amIAttending() {
    bool result = false;

    if (widget.userDoc['myEvents'].contains(widget.eventData['id'])) {
      result = true;
    }

    return result;
  }

  bool isEventFull() {
    bool result = false;

    if (widget.eventData['rsvpList'].length >=
        double.parse(widget.eventData['max'])) {
      result = true;
    }

    return result;
  }

  getScreenNameFromUid(uid) async {
    String screenName = 'null';
    await UserController.instance.getScreenName(uid).then((result) {
      screenName = result;
    });

    return screenName;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventDetailMobile2Page(
        eventData: widget.eventData,
        userDoc: widget.userDoc,
        amIAttending: amIAttending,
        // getScreenNameFromUid: getScreenNameFromUid,
        amIHost: amIHost,
        isEventFull: isEventFull,
      ),
    );
  }
}

// ----------------NEW-------------------//
class EventDetailMobile2Page extends StatefulWidget {
  final Function() isEventFull;
  final Function() amIHost;
  final Function() amIAttending;
  final Map userDoc;
  final Map eventData;

  const EventDetailMobile2Page({
    Key? key,
    required this.amIAttending,
    required this.amIHost,
    required this.isEventFull,
    required this.eventData,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<EventDetailMobile2Page> createState() => _EventDetailMobile2PageState();
}

class _EventDetailMobile2PageState extends State<EventDetailMobile2Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            AppBarWidget(
              profileUrl: widget.userDoc['profilePicture'],
            ),
            EventDetailsWidget(
              eventData: widget.eventData,
            ),
            // BottomAppBarWidget(
            //   userDoc: widget.userDoc,
            //   eventData: widget.eventData,
            //   amIHost: widget.amIHost,
            //   isEventFull: widget.isEventFull,
            //   amIAttending: widget.amIAttending,
            // ),
            BottomBtnsWidget(
              userDoc: widget.userDoc,
              eventData: widget.eventData,
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------- MOBILE -------------------------//

class EventDetailMobilePage extends StatefulWidget {
  final Function() isEventFull;
  final Function() amIHost;
  final Function() amIAttending;
  final Function(String) getScreenNameFromUid;
  final Map userDoc;
  final Map eventData;
  const EventDetailMobilePage({
    Key? key,
    required this.amIHost,
    required this.eventData,
    required this.userDoc,
    required this.amIAttending,
    required this.getScreenNameFromUid,
    required this.isEventFull,
  }) : super(key: key);

  @override
  State<EventDetailMobilePage> createState() => _EventDetailMobilePageState();
}

class _EventDetailMobilePageState extends State<EventDetailMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            AppBarWidget(
              profileUrl: widget.userDoc['profilePicture'],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              height: MediaQuery.of(context).size.height * .8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                      width: MediaQuery.of(context).size.width * .8,
                      child: FittedBox(
                        child: Text(
                          widget.eventData['title'],
                          style: GoogleFonts.yellowtail(
                            color: global.secondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .4,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Center(
                        child: Image.network(
                          widget.eventData['eventImage'],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .3,
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
                      child:
                          Center(child: Text(widget.eventData['description'])),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EventMapWidget(eventData: widget.eventData),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .4,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .03,
                                width: MediaQuery.of(context).size.width * .4,
                                child: FittedBox(
                                  alignment: Alignment.centerRight,
                                  child: FutureBuilder(
                                    future: UserController.instance
                                        .getScreenName(
                                            widget.eventData['host']),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          print('error!');
                                        }
                                        return RichText(
                                          textAlign: TextAlign.end,
                                          text: TextSpan(
                                            text: 'host : ',
                                            style: const TextStyle(
                                              color: global.secondaryColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: snapshot.data,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return RichText(
                                          textAlign: TextAlign.end,
                                          text: const TextSpan(
                                            text: 'host : ',
                                            style: TextStyle(
                                              color: global.secondaryColor,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: 'null',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              AttendanceWidget(
                                userDoc: widget.userDoc,
                                eventData: widget.eventData,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .03,
                                width: MediaQuery.of(context).size.width * .4,
                                child: FittedBox(
                                  alignment: Alignment.centerRight,
                                  child: RichText(
                                    textAlign: TextAlign.end,
                                    text: TextSpan(
                                      text: 'category : ',
                                      style: const TextStyle(
                                        color: global.secondaryColor,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: widget.eventData['category'],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              (widget.amIHost())
                                  ? RoundedBtnWidget(
                                      height: null,
                                      width: null,
                                      func: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
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
                                                    color:
                                                        global.secondaryColor,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await EventController.instance
                                                      .closeEvent(widget
                                                          .eventData['id'])
                                                      .then(
                                                    (result) async {
                                                      print(
                                                          'event_detail_page closeEvent result $result');
                                                      if (result) {
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                const LandingPage(),
                                                          ),
                                                          (route) => false,
                                                        );
                                                      } else {
                                                        print(
                                                            'closeEvent error');
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
                                  : (widget.amIAttending())
                                      ? RoundedBtnWidget(
                                          height: null,
                                          width: null,
                                          func: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                title: const Text(
                                                    'Cancel RSVP for this event ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'back',
                                                      style: TextStyle(
                                                          color: global
                                                              .secondaryColor),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      EventController.instance
                                                          .updateEventRSVP(
                                                              widget.userDoc,
                                                              widget.eventData)
                                                          .then(
                                                        (updateEventRSVPResult) {
                                                          if (updateEventRSVPResult) {
                                                            UserController
                                                                .instance
                                                                .updateMyEvent(
                                                              widget.userDoc[
                                                                  'uid'],
                                                              widget.eventData[
                                                                  'id'],
                                                            )
                                                                .then(
                                                                    (updateMyEventResult) {
                                                              if (updateMyEventResult) {
                                                                Navigator
                                                                    .pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        const LandingPage(),
                                                                  ),
                                                                  (route) =>
                                                                      false,
                                                                );
                                                              } else {
                                                                print(
                                                                    'updateMyEvent error');
                                                              }
                                                            });
                                                          } else {
                                                            print(
                                                                'updateEventRSVP error');
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
                                      : (widget.isEventFull())
                                          ? RoundedBtnWidget(
                                              height: null,
                                              width: null,
                                              func: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                      'Sorry, Event is full',
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'OK',
                                                          style: TextStyle(
                                                            color: global
                                                                .secondaryColor,
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
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text(
                                                        'Join this event ?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color: global
                                                                  .secondaryColor),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          EventController
                                                              .instance
                                                              .updateEventRSVP(
                                                                  widget
                                                                      .userDoc,
                                                                  widget
                                                                      .eventData)
                                                              .then(
                                                            (updateEventRSVPResult) {
                                                              if (updateEventRSVPResult) {
                                                                UserController
                                                                    .instance
                                                                    .updateMyEvent(
                                                                  widget.userDoc[
                                                                      'uid'],
                                                                  widget.eventData[
                                                                      'id'],
                                                                )
                                                                    .then(
                                                                        (updateMyEventResult) {
                                                                  if (updateMyEventResult) {
                                                                    Navigator
                                                                        .pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (BuildContext context) =>
                                                                                const LandingPage(),
                                                                      ),
                                                                      (route) =>
                                                                          false,
                                                                    );
                                                                  } else {
                                                                    print(
                                                                        'updateMyEvent error');
                                                                  }
                                                                });
                                                              } else {
                                                                print(
                                                                    'updateEventRSVP error');
                                                              }
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                          'JOIN',
                                                          style: TextStyle(
                                                            color: global
                                                                .primaryColor,
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
                              (widget.amIHost())
                                  ? RoundedBtnWidget(
                                      height: null,
                                      width: null,
                                      func: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title: const Text(
                                                'Cancel this event ? '),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'No',
                                                  style: TextStyle(
                                                    color:
                                                        global.secondaryColor,
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  await UserController.instance
                                                      .cancelEvent(
                                                    widget.eventData['id'],
                                                    widget
                                                        .eventData['rsvpList'],
                                                  )
                                                      .then((result) async {
                                                    await EventController
                                                        .instance
                                                        .deleteEvent(widget
                                                            .eventData['id'])
                                                        .then(
                                                            (deleteEventResult) {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
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
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                  ],
                ),
              ),
            ),
            BottomAppBarWidget(
              userDoc: widget.userDoc,
              eventData: widget.eventData,
              amIHost: widget.amIHost,
              isEventFull: widget.isEventFull,
              amIAttending: widget.amIAttending,
            ),
          ],
        ),
      ),
    );
  }
}
