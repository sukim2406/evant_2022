import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

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
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventDetailsMobileWidget(
        eventData: widget.eventData,
      ),
    );
  }
}

// -------------------------------------- MOBILE ------------------------------------ //

class EventDetailsMobileWidget extends StatefulWidget {
  final Map eventData;
  const EventDetailsMobileWidget({
    Key? key,
    required this.eventData,
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
        color: global.secondaryColor,
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
              height: MediaQuery.of(context).size.height * .02,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .3,
              child: Image.network(
                widget.eventData['eventImage'],
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
