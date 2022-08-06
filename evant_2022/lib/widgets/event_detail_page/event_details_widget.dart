import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/event_detail_page/event_map_widget.dart';
import '../../widgets/event_detail_page/attendance_widget.dart';
import '../../widgets/boxed_textfield_widget.dart';

class EventDetailsWidget extends StatefulWidget {
  final bool amIhost;
  final Map eventData;
  final Map userDoc;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  final TextEditingController attendanceController;
  final TextEditingController statusController;
  final TextEditingController maxController;
  final Function(String) setNewCategory;
  final Function(String) setNewStatus;
  final void Function(DateTime) setStartTime;
  final void Function(DateTime) setEndTime;
  final DateTime startTime;
  final DateTime endTime;
  const EventDetailsWidget({
    Key? key,
    required this.eventData,
    required this.userDoc,
    required this.titleController,
    required this.descriptionController,
    required this.categoryController,
    required this.attendanceController,
    required this.statusController,
    required this.maxController,
    required this.amIhost,
    required this.setNewCategory,
    required this.setNewStatus,
    required this.setEndTime,
    required this.setStartTime,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  State<EventDetailsWidget> createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventDetailsMobileWidget(
        eventData: widget.eventData,
        titleController: widget.titleController,
        descriptionContoller: widget.descriptionController,
        categoryController: widget.categoryController,
        attendanceController: widget.attendanceController,
        statusController: widget.statusController,
        maxController: widget.maxController,
        userDoc: widget.userDoc,
        amIhost: widget.amIhost,
        setNewCategory: widget.setNewCategory,
        setNewStatus: widget.setNewStatus,
        setEndTime: widget.setEndTime,
        setStartTime: widget.setStartTime,
        startTime: widget.startTime,
        endTime: widget.endTime,
      ),
    );
  }
}

// -------------------------------------- MOBILE ------------------------------------ //

class EventDetailsMobileWidget extends StatefulWidget {
  final bool amIhost;
  final TextEditingController titleController;
  final TextEditingController descriptionContoller;
  final TextEditingController categoryController;
  final TextEditingController attendanceController;
  final TextEditingController statusController;
  final TextEditingController maxController;
  final Map eventData;
  final Map userDoc;
  final Function(String) setNewCategory;
  final Function(String) setNewStatus;
  final void Function(DateTime) setStartTime;
  final void Function(DateTime) setEndTime;
  final DateTime startTime;
  final DateTime endTime;
  const EventDetailsMobileWidget({
    Key? key,
    required this.eventData,
    required this.titleController,
    required this.descriptionContoller,
    required this.categoryController,
    required this.attendanceController,
    required this.statusController,
    required this.maxController,
    required this.userDoc,
    required this.amIhost,
    required this.setNewCategory,
    required this.setNewStatus,
    required this.setEndTime,
    required this.setStartTime,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  State<EventDetailsMobileWidget> createState() =>
      _EventDetailsMobileWidgetState();
}

class _EventDetailsMobileWidgetState extends State<EventDetailsMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .8,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height * .3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(
                    20,
                  ),
                  topRight: Radius.circular(
                    20,
                  ),
                ),
                child: Image.network(
                  widget.eventData['eventImage'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Title',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: widget.amIhost,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: widget.titleController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Description',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: widget.amIhost,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: widget.descriptionContoller,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Category',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: DropdownButton<String>(
                      value: widget.categoryController.text,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: global.secondaryColor),
                      underline: Container(
                        height: 2,
                        color: global.secondaryColor,
                      ),
                      items: global.categoryStrings
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (widget.amIhost)
                          ? (String? newValue) {
                              widget.setNewCategory(newValue!);
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Attendance',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  AttendanceWidget(
                    userDoc: widget.userDoc,
                    eventData: widget.eventData,
                    attendanceController: widget.attendanceController,
                    maxController: widget.maxController,
                    amIHost: widget.amIhost,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Event Date & Time',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (widget.amIhost) {
                              DatePicker.showDateTimePicker(
                                context,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2030, 12, 31),
                                onConfirm: (date) {
                                  widget.setStartTime(date);
                                },
                              );
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .27,
                            child: TextField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: TextEditingController(
                                text: widget.startTime
                                    .toString()
                                    .substring(0, 19),
                              ),
                            ),
                          ),
                        ),
                        const Text(' to '),
                        GestureDetector(
                          onTap: () {
                            if (widget.amIhost) {
                              DatePicker.showDateTimePicker(
                                context,
                                minTime: DateTime.now(),
                                maxTime: DateTime(2030, 12, 31),
                                onConfirm: (date) {
                                  widget.setEndTime(date);
                                },
                              );
                            }
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .27,
                            child: TextField(
                              enabled: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              controller: TextEditingController(
                                text:
                                    widget.endTime.toString().substring(0, 19),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: const Text(
                      'Status',
                      style: TextStyle(
                        color: global.secondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .6,
                    child: DropdownButton<String>(
                      value: widget.statusController.text,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: global.secondaryColor),
                      underline: Container(
                        height: 2,
                        color: global.secondaryColor,
                      ),
                      items: global.statusStrings
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (widget.amIhost)
                          ? (String? newValue) {
                              widget.setNewStatus(newValue!);
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            EventMapWidget(
              eventData: widget.eventData,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
          ],
        ),
      ),
    );
  }
}
