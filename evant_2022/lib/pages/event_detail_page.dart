import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/event_detail_page/attendance_widget.dart';
import '../widgets/event_detail_page/event_map_widget.dart';

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
      mobileVer: EventDetailMobilePage(
        eventData: widget.eventData,
        userDoc: widget.userDoc,
        amIAttending: amIAttending,
        getScreenNameFromUid: getScreenNameFromUid,
        amIHost: amIHost,
        isEventFull: isEventFull,
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
                              RoundedBtnWidget(
                                height:
                                    MediaQuery.of(context).size.height * .05,
                                width: MediaQuery.of(context).size.width * .3,
                                func: () {
                                  print('Im going!');
                                },
                                label: (widget.amIHost())
                                    ? 'CANCEL EVENT'
                                    : (widget.amIAttending())
                                        ? 'CANCEL RSVP'
                                        : 'JOIN',
                                btnColor: (widget.amIHost())
                                    ? Colors.redAccent
                                    : (widget.amIAttending())
                                        ? Colors.redAccent
                                        : global.primaryColor,
                                txtColor: Colors.white,
                              ),
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
            SizedBox(
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
                  RoundedBtnWidget(
                    height: null,
                    width: null,
                    func: () async {
                      if (widget.amIHost()) {
                        await EventController.instance
                            .closeEvent(widget.eventData['id'])
                            .then((result) async {
                          print('event_detail_page closeEvent result $result');
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
                        });
                      } else if (widget.isEventFull()) {
                      } else {
                        EventController.instance
                            .updateEventRSVP(widget.userDoc, widget.eventData)
                            .then(
                          (result) {
                            if (result) {
                              UserController.instance
                                  .updateMyEvent(
                                widget.userDoc['uid'],
                                widget.eventData['id'],
                              )
                                  .then(
                                (result) {
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
                                    print('updateMyEvent error');
                                  }
                                },
                              );
                            } else {
                              print('joinEvent error');
                            }
                          },
                        );
                      }
                    },
                    label: (widget.amIHost())
                        ? 'CLOSE EVENT'
                        : (widget.amIAttending())
                            ? 'CANCEL RSVP'
                            : (widget.isEventFull())
                                ? 'EVENT FULL'
                                : 'JOIN',
                    btnColor: (widget.amIHost())
                        ? Colors.redAccent
                        : (widget.amIAttending())
                            ? Colors.redAccent
                            : (widget.isEventFull())
                                ? Colors.grey
                                : global.primaryColor,
                    txtColor: Colors.white,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
