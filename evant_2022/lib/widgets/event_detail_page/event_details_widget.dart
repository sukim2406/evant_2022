import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/event_detail_page/event_map_widget.dart';

class EventDetailsWidget extends StatefulWidget {
  final Map eventData;
  const EventDetailsWidget({
    Key? key,
    required this.eventData,
  }) : super(key: key);

  @override
  State<EventDetailsWidget> createState() => _EventDetailsWidgetState();
}

class _EventDetailsWidgetState extends State<EventDetailsWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController attendanceController;
  late TextEditingController statusController;

  @override
  void initState() {
    // TODO: implement initState

    titleController = TextEditingController();
    descriptionController = TextEditingController();
    categoryController = TextEditingController();
    attendanceController = TextEditingController();
    statusController = TextEditingController();
    setState(() {
      titleController.text = widget.eventData['title'];
      descriptionController.text = widget.eventData['description'];
      categoryController.text = widget.eventData['category'];
      attendanceController.text =
          '${widget.eventData['rsvpList'].length} / ${widget.eventData['max']}';
      statusController.text = widget.eventData['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventDetailsMobileWidget(
        eventData: widget.eventData,
        titleController: titleController,
        descriptionContoller: descriptionController,
        categoryController: categoryController,
        attendanceController: attendanceController,
        statusController: statusController,
      ),
    );
  }
}

// -------------------------------------- MOBILE ------------------------------------ //

class EventDetailsMobileWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionContoller;
  final TextEditingController categoryController;
  final TextEditingController attendanceController;
  final TextEditingController statusController;
  final Map eventData;
  const EventDetailsMobileWidget({
    Key? key,
    required this.eventData,
    required this.titleController,
    required this.descriptionContoller,
    required this.categoryController,
    required this.attendanceController,
    required this.statusController,
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
              height: MediaQuery.of(context).size.height * .01,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: false,
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
              height: MediaQuery.of(context).size.height * .01,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: false,
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
              height: MediaQuery.of(context).size.height * .01,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: widget.categoryController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      enabled: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: widget.attendanceController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
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
                    width: MediaQuery.of(context).size.width * .6,
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      controller: widget.statusController,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            EventMapWidget(
              eventData: widget.eventData,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
          ],
        ),
      ),
    );
  }
}
