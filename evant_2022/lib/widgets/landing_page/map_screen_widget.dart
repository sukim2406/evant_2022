import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/event_controller.dart';

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
  List loadedEvents = [];
  late Set<Circle> circles;

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

  void addEventMarker(eventData) {
    MarkerId markerId = MarkerId(eventData['id']);
    final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          eventData['lat'],
          eventData['lng'],
        ),
        onTap: () {
          print(eventData);
        });
    setState(() {
      markers[markerId] = marker;
    });
  }

  void loadEvents() async {
    var temp = await EventController.instance.getEvents(
      widget.userDoc['homeground']['lat'],
      widget.userDoc['homeground']['lng'],
    );
    setState(() {
      loadedEvents = temp;
    });
    loadedEvents.forEach((event) {
      addEventMarker(event);
    });
  }

  @override
  void initState() {
    super.initState();
    circles = {
      Circle(
        circleId: const CircleId('myCircle'),
        center: LatLng(
          widget.userDoc['homeground']['lat'],
          widget.userDoc['homeground']['lng'],
        ),
        radius: 10000,
        fillColor: const Color.fromRGBO(9, 212, 3, .3),
        strokeColor: global.primaryColor,
        strokeWidth: 1,
      ),
    };
    initCameraPosiiton = CameraPosition(
      target: LatLng(
        widget.userDoc['homeground']['lat'],
        widget.userDoc['homeground']['lng'],
      ),
      zoom: 15,
    );
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: MapScreenMobileWidget(
        circles: circles,
        initCameraPosition: initCameraPosiiton,
        addTempMarker: addTempMarker,
        controller: controller,
        markers: markers,
        tempMarkerPlaced: tempMarkerPlaced,
        userDoc: widget.userDoc,
        loadedEvents: loadedEvents,
      ),
    );
  }
}

// ---------------------- MOBILE -------------------- //
class MapScreenMobileWidget extends StatefulWidget {
  final Set<Circle> circles;
  final List loadedEvents;
  final Map userDoc;
  final Completer<GoogleMapController> controller;
  final void Function(LatLng) addTempMarker;
  final CameraPosition initCameraPosition;
  final Map<MarkerId, Marker> markers;
  final bool tempMarkerPlaced;
  const MapScreenMobileWidget({
    Key? key,
    required this.circles,
    required this.loadedEvents,
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
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
            width: MediaQuery.of(context).size.width * .9,
            child: Row(
              children: [
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .3,
                  func: () {
                    print('hi');
                  },
                  label: 'JOIN Events',
                  btnColor: global.secondaryColor,
                  txtColor: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .8,
            width: MediaQuery.of(context).size.width * 8,
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
                  circles: widget.circles,
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
          ),
        ],
      ),
    );
  }
}
