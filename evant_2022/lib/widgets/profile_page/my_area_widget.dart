import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class MyAreaWidget extends StatefulWidget {
  final Map userDoc;
  const MyAreaWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<MyAreaWidget> createState() => _MyAreaWidgetState();
}

class _MyAreaWidgetState extends State<MyAreaWidget> {
  late CameraPosition initCameraPosition;
  late Set<Marker> markserSet;

  Completer<GoogleMapController> controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    initCameraPosition = CameraPosition(
      target: LatLng(
        widget.userDoc['homeground']['lat'],
        widget.userDoc['homeground']['lng'],
      ),
      zoom: 17,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: MyAreaMobileWidget(
        initialCameraPosition: initCameraPosition,
        controller: controller,
        markers: markers,
      ),
    );
  }
}

// --------------------- MOBILE --------------------- //

class MyAreaMobileWidget extends StatefulWidget {
  final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> controller;
  final Map<MarkerId, Marker> markers;
  const MyAreaMobileWidget({
    Key? key,
    required this.initialCameraPosition,
    required this.controller,
    required this.markers,
  }) : super(key: key);

  @override
  State<MyAreaMobileWidget> createState() => _MyAreaMobileWidgetState();
}

class _MyAreaMobileWidgetState extends State<MyAreaMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        color: global.secondaryColor,
        border: Border.all(
          color: global.secondaryColor,
          width: 5,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .65,
            width: MediaQuery.of(context).size.width * .9,
            color: Colors.grey,
            child: GoogleMap(
              initialCameraPosition: widget.initialCameraPosition,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                widget.controller.complete(controller);
              },
              markers: Set<Marker>.of(widget.markers.values),
            ),
          ),
        ],
      ),
    );
  }
}
