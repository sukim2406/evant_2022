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
  Map<MarkerId, Marker> joinableMarkers = <MarkerId, Marker>{};
  Map<MarkerId, Marker> createMarkers = <MarkerId, Marker>{};
  bool tempMarkerPlaced = false;
  List loadedEvents = [];
  late Set<Circle> circles;
  bool createMap = false;

  void setCreateEventMap() {
    setState(() {
      createMap = true;
    });
  }

  void setJoinEventMap() {
    setState(() {
      createMap = false;
    });
  }

  void setMapChoice() {
    setState(() {
      createMap = !createMap;
      print(createMap);
    });
  }

  void addTempMarker(LatLng point) {
    const MarkerId markerId = MarkerId('tempMarker');
    final Marker marker = Marker(
        markerId: markerId,
        position: point,
        onTap: () {
          setState(() {
            createMarkers.remove(markerId);
            tempMarkerPlaced = false;
          });
        });
    setState(() {
      createMarkers[markerId] = marker;
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
      joinableMarkers[markerId] = marker;
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
        joinableMarkers: joinableMarkers,
        createMarkers: createMarkers,
        tempMarkerPlaced: tempMarkerPlaced,
        userDoc: widget.userDoc,
        loadedEvents: loadedEvents,
        setJoinEventMap: setJoinEventMap,
        setCreateEventMap: setCreateEventMap,
        createEventMap: createMap,
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
  final Map<MarkerId, Marker> joinableMarkers;
  final Map<MarkerId, Marker> createMarkers;
  final bool tempMarkerPlaced;
  final VoidCallback setJoinEventMap;
  final VoidCallback setCreateEventMap;
  final bool createEventMap;
  const MapScreenMobileWidget({
    Key? key,
    required this.circles,
    required this.loadedEvents,
    required this.initCameraPosition,
    required this.addTempMarker,
    required this.controller,
    required this.joinableMarkers,
    required this.createMarkers,
    required this.tempMarkerPlaced,
    required this.userDoc,
    required this.setJoinEventMap,
    required this.setCreateEventMap,
    required this.createEventMap,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .3,
                  func: () {
                    widget.setJoinEventMap();
                  },
                  label: 'JOIN Events',
                  btnColor: (widget.createEventMap)
                      ? global.secondaryColor
                      : global.primaryColor,
                  txtColor: Colors.white,
                ),
                RoundedBtnWidget(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .3,
                  func: () {
                    widget.setCreateEventMap();
                  },
                  label: 'CREATE Events',
                  btnColor: (widget.createEventMap)
                      ? global.primaryColor
                      : global.secondaryColor,
                  txtColor: Colors.white,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
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
                  markers: (widget.createEventMap)
                      ? Set<Marker>.of(widget.createMarkers.values)
                      : Set<Marker>.of(widget.joinableMarkers.values),
                  onTap: (widget.createEventMap) ? widget.addTempMarker : null,
                  circles: (widget.createEventMap)
                      ? const <Circle>{}
                      : widget.circles,
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
                                        .createMarkers[
                                            const MarkerId('tempMarker')]!
                                        .position,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          (widget.createEventMap)
                              ? 'Place marker by clicking on the map'
                              : 'Events within 10 km of your homeground are shown',
                          style: const TextStyle(
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
