import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';

class EventMapWidget extends StatefulWidget {
  final Map eventData;
  const EventMapWidget({
    Key? key,
    required this.eventData,
  }) : super(key: key);

  @override
  State<EventMapWidget> createState() => _EventMapWidgetState();
}

class _EventMapWidgetState extends State<EventMapWidget> {
  late CameraPosition initCameraPosition;
  late Set<Marker> markerSet;
  Completer<GoogleMapController> controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> goToCenter() async {
    final GoogleMapController mapController = await controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(initCameraPosition),
    );
  }

  LatLng getMarkerPosition() {
    final MarkerId markerId = MarkerId('event');
    return markers[markerId]!.position;
  }

  void addMarker(LatLng point) {
    final MarkerId markerId = MarkerId('event');
    final Marker marker = Marker(
      markerId: markerId,
      position: point,
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  void initState() {
    super.initState();
    initCameraPosition = CameraPosition(
      target: LatLng(
        widget.eventData['location']['lat'],
        widget.eventData['location']['lng'],
      ),
      zoom: 17,
    );
    addMarker(
      LatLng(
        widget.eventData['location']['lat'],
        widget.eventData['location']['lng'],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: EventMapMobileWidget(
        goToCenter: goToCenter,
        getMarkerPosition: getMarkerPosition,
        eventData: widget.eventData,
        initialCameraPosition: initCameraPosition,
        controller: controller,
        markers: markers,
      ),
    );
  }
}

// --------------------- MOBILE -----------------------//

class EventMapMobileWidget extends StatefulWidget {
  final Function goToCenter;
  final Function getMarkerPosition;
  final Map eventData;
  final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> controller;
  final Map<MarkerId, Marker> markers;

  const EventMapMobileWidget({
    Key? key,
    required this.goToCenter,
    required this.getMarkerPosition,
    required this.eventData,
    required this.initialCameraPosition,
    required this.controller,
    required this.markers,
  }) : super(key: key);

  @override
  State<EventMapMobileWidget> createState() => _EventMapMobileWidgetState();
}

class _EventMapMobileWidgetState extends State<EventMapMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      width: MediaQuery.of(context).size.width * .6,
      child: GoogleMap(
        initialCameraPosition: widget.initialCameraPosition,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          widget.controller.complete(controller);
        },
        markers: Set<Marker>.of(widget.markers.values),
      ),
    );
  }
}
