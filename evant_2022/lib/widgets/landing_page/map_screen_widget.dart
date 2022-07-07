import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/global_controller.dart' as global;

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';

import '../../pages/new_event_page.dart';

class MapScreenWidget extends StatefulWidget {
  final Map userDoc;
  const MapScreenWidget({
    Key? key,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<MapScreenWidget> createState() => _MapScreenWidgetState();
}

class _MapScreenWidgetState extends State<MapScreenWidget> {
  late CameraPosition initCameraPosiiton;
  Completer<GoogleMapController> controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool tempMarkerPlaced = false;

  void addTempMarker(LatLng point) {
    const MarkerId markerId = MarkerId('tempMarker');
    final Marker marker = Marker(
        markerId: markerId,
        position: point,
        onTap: () {
          setState(() {
            markers.remove(markerId);
            tempMarkerPlaced = false;
          });
        });
    setState(() {
      markers[markerId] = marker;
      tempMarkerPlaced = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initCameraPosiiton = CameraPosition(
      target: LatLng(
        widget.userDoc['homeground']['lat'],
        widget.userDoc['homeground']['lng'],
      ),
      zoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: MapScreenMobileWidget(
        initCameraPosition: initCameraPosiiton,
        addTempMarker: addTempMarker,
        controller: controller,
        markers: markers,
        tempMarkerPlaced: tempMarkerPlaced,
        userDoc: widget.userDoc,
      ),
    );
  }
}

// ---------------------- MOBILE -------------------- //
class MapScreenMobileWidget extends StatefulWidget {
  final Map userDoc;
  final Completer<GoogleMapController> controller;
  final void Function(LatLng) addTempMarker;
  final CameraPosition initCameraPosition;
  final Map<MarkerId, Marker> markers;
  final bool tempMarkerPlaced;
  const MapScreenMobileWidget({
    Key? key,
    required this.initCameraPosition,
    required this.addTempMarker,
    required this.controller,
    required this.markers,
    required this.tempMarkerPlaced,
    required this.userDoc,
  }) : super(key: key);

  @override
  State<MapScreenMobileWidget> createState() => _MapScreenMobileWidgetState();
}

class _MapScreenMobileWidgetState extends State<MapScreenMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * .9,
      width: MediaQuery.of(context).size.width * .9,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: widget.initCameraPosition,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController controller) {
              widget.controller.complete(controller);
            },
            markers: Set<Marker>.of(widget.markers.values),
            onTap: widget.addTempMarker,
          ),
          (widget.tempMarkerPlaced)
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RoundedBtnWidget(
                      height: null,
                      width: null,
                      label: 'Add Event',
                      btnColor: global.primaryColor,
                      txtColor: Colors.white,
                      func: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewEventPage(
                              userDoc: widget.userDoc,
                              point: widget
                                  .markers[const MarkerId('tempMarker')]!
                                  .position,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Place marker by clicking on the map',
                    style: TextStyle(
                      color: global.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
