import 'package:flutter/material.dart';

import '../../widgets/responsive_layout_widget.dart';

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
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .8,
      child: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
