import 'package:evant_2022/controllers/user_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class AttendanceWidget extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  final TextEditingController attendanceController;
  final TextEditingController maxController;
  final bool amIHost;
  const AttendanceWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
    required this.attendanceController,
    required this.maxController,
    required this.amIHost,
  }) : super(key: key);

  @override
  State<AttendanceWidget> createState() => _AttendanceWidgetState();
}

class _AttendanceWidgetState extends State<AttendanceWidget> {
  bool showList = true;
  List attendanceList = [];

  void toggleList() {
    setState(() {
      showList = !showList;
    });
  }

  getAttendanceList(uid) async {
    Map info = {};
    String screenName = '';
    String profileUrl = '';

    await UserController.instance.getScreenName(uid).then((result) {
      screenName = result;
    });
    await UserController.instance.getProfileUrl(uid).then((result) {
      profileUrl = result;
    });

    info['screenName'] = screenName;
    info['profileUrl'] = profileUrl;

    return info;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.eventData['rsvpList'].forEach((attendee) {
      getAttendanceList(attendee).then((result) {
        attendanceList.add(result);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: AttendanceMobileWidget(
        userDoc: widget.userDoc,
        eventData: widget.eventData,
        toggleList: toggleList,
        showList: showList,
        attendanceList: attendanceList,
        attendanceController: widget.attendanceController,
        maxController: widget.maxController,
        amIhost: widget.amIHost,
      ),
    );
  }
}

// ----------------------------------- MOBILE ------------------------------- //

class AttendanceMobileWidget extends StatefulWidget {
  final Map userDoc;
  final Map eventData;
  final bool showList;
  final VoidCallback toggleList;
  final List attendanceList;
  final TextEditingController attendanceController;
  final TextEditingController maxController;
  final bool amIhost;
  const AttendanceMobileWidget({
    Key? key,
    required this.userDoc,
    required this.eventData,
    required this.showList,
    required this.toggleList,
    required this.attendanceList,
    required this.attendanceController,
    required this.maxController,
    required this.amIhost,
  }) : super(key: key);

  @override
  State<AttendanceMobileWidget> createState() => _AttendanceMobileWidgetState();
}

class _AttendanceMobileWidgetState extends State<AttendanceMobileWidget> {
  final layerLink = LayerLink();
  OverlayEntry? entry;

  showRsvpOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height),
          child: buildOverlay(),
        ),
      ),
    );
    overlay.insert(entry!);
  }

  void hideOverLay() {
    entry?.remove();
    entry = null;
  }

  Widget buildOverlay() => Material(
        elevation: 8,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width * .2,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Color.fromRGBO(82, 82, 82, .5),
          ),
          child: ListView.builder(
            itemCount: widget.attendanceList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Image.network(
                  widget.attendanceList[index]['profileUrl'],
                  fit: BoxFit.cover,
                ),
                title: Text(widget.attendanceList[index]['screenName']),
              );
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: GestureDetector(
                onTap: () {
                  widget.toggleList();
                  if (widget.showList) {
                    showRsvpOverlay();
                  } else {
                    hideOverLay();
                  }
                },
                child: TextField(
                  enabled: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: widget.attendanceController,
                ),
              ),
            ),
            const Text(' / '),
            SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              child: TextField(
                enabled: widget.amIhost,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                controller: widget.maxController,
              ),
            ),
          ],
        ),
      ),
      // SizedBox(
      //   height: MediaQuery.of(context).size.height * .03,
      //   width: MediaQuery.of(context).size.width * .4,
      //   child: FittedBox(
      //     alignment: Alignment.centerRight,
      //     child: RichText(
      //       textAlign: TextAlign.end,
      //       text: TextSpan(
      //         text: 'attendance : ',
      //         style: const TextStyle(
      //           color: global.secondaryColor,
      //         ),
      //         children: [
      //           TextSpan(
      //             text: widget.eventData['rsvpList'].length.toString(),
      //             style: TextStyle(
      //               color: (widget.eventData['rsvpList'].length.toString() ==
      //                       widget.eventData['max'])
      //                   ? Colors.red
      //                   : global.primaryColor,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             recognizer: TapGestureRecognizer()
      //               ..onTap = () {
      //                 widget.toggleList();
      //                 if (widget.showList) {
      //                   showRsvpOverlay();
      //                 } else {
      //                   hideOverLay();
      //                 }
      //               },
      //           ),
      //           const TextSpan(
      //             text: '/ ',
      //             style: TextStyle(
      //               color: global.secondaryColor,
      //             ),
      //           ),
      //           TextSpan(
      //             text: widget.eventData['max'],
      //             style: const TextStyle(
      //               color: Colors.black,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
