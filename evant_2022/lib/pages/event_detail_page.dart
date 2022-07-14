import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/responsive_layout_widget.dart';
import '../widgets/landing_page/app_bar_widget.dart';
import '../widgets/rounded_btn_widget.dart';
import '../widgets/event_detail_page/attendance_widget.dart';
import '../widgets/event_detail_page/event_map_widget.dart';

import '../controllers/global_controller.dart' as global;

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
  bool rsvpListExpanded = false;

  void setRsvpList() {
    setState(() {
      rsvpListExpanded = !rsvpListExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventDetailMobilePage(
        eventData: widget.eventData,
        userDoc: widget.userDoc,
        setRsvpList: setRsvpList,
        rsvpListExpanded: rsvpListExpanded,
      ),
    );
  }
}

// --------------------- MOBILE -------------------------//

class EventDetailMobilePage extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  final VoidCallback setRsvpList;
  final bool rsvpListExpanded;
  const EventDetailMobilePage({
    Key? key,
    required this.eventData,
    required this.userDoc,
    required this.setRsvpList,
    required this.rsvpListExpanded,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarWidget(
                profileUrl: widget.userDoc['profilePicture'],
              ),
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
                child: Center(child: Text(widget.eventData['description'])),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EventMapWidget(eventData: widget.eventData),
                  Container(
                    height: MediaQuery.of(context).size.height * .4,
                    width: MediaQuery.of(context).size.width * .4,
                    // color: Colors.grey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
                          width: MediaQuery.of(context).size.width * .4,
                          child: FittedBox(
                            alignment: Alignment.centerRight,
                            child: RichText(
                              textAlign: TextAlign.end,
                              text: TextSpan(
                                text: 'host : ',
                                style: const TextStyle(
                                  color: global.secondaryColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.eventData['host'],
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
                        AttendanceWidget(
                          userDoc: widget.userDoc,
                          eventData: widget.eventData,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .03,
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
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .4,
                          func: () {
                            print('Im going!');
                          },
                          label: 'I\'m Going! ',
                          btnColor: Colors.white,
                          txtColor: global.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
