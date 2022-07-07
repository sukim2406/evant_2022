import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/responsive_layout_widget.dart';
import '../../widgets/rounded_btn_widget.dart';
import '../../widgets/loading_widget.dart';

import '../../controllers/global_controller.dart' as global;
import '../../controllers/user_controller.dart';

import '../../pages/landing_page.dart';

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

  Future<void> goToCenter() async {
    final GoogleMapController mapController = await controller.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(initCameraPosition),
    );
  }

  LatLng getMarkerPosition() {
    final MarkerId markerId = MarkerId('homeground');
    return markers[markerId]!.position;
  }

  void addMarker(LatLng point) {
    final MarkerId markerId = MarkerId('homeground');
    final Marker marker = Marker(
      markerId: markerId,
      position: point,
      onTap: () {
        setState(() {
          markers.remove(markerId);
        });
      },
    );
    setState(
      () {
        markers[markerId] = marker;
      },
    );
  }

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
    addMarker(
      LatLng(
        widget.userDoc['homeground']['lat'],
        widget.userDoc['homeground']['lng'],
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
      mobileVer: MyAreaMobileWidget(
        initialCameraPosition: initCameraPosition,
        controller: controller,
        markers: markers,
        addMarker: addMarker,
        userDoc: widget.userDoc,
        getMarkerPosition: getMarkerPosition,
        goToCenter: goToCenter,
      ),
    );
  }
}

// --------------------- MOBILE --------------------- //

class MyAreaMobileWidget extends StatefulWidget {
  final Function goToCenter;
  final Function getMarkerPosition;
  final void Function(LatLng) addMarker;
  final Map userDoc;
  final CameraPosition initialCameraPosition;
  final Completer<GoogleMapController> controller;
  final Map<MarkerId, Marker> markers;
  const MyAreaMobileWidget({
    Key? key,
    required this.initialCameraPosition,
    required this.controller,
    required this.markers,
    required this.addMarker,
    required this.userDoc,
    required this.getMarkerPosition,
    required this.goToCenter,
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
              onTap: widget.addMarker,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          RoundedBtnWidget(
            height: null,
            width: MediaQuery.of(context).size.width * .7,
            func: () {
              widget.goToCenter();
            },
            label: 'current HOMEGROUND',
            btnColor: global.primaryColor,
            txtColor: Colors.white,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          (widget.markers.isEmpty)
              ? const SizedBox(
                  child: Text(
                    'place a new marker by clicking on the map',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedBtnWidget(
            height: null,
            width: MediaQuery.of(context).size.width * .7,
            func: () async {
              if (widget.markers.isEmpty) {
              } else {
                LatLng newPosition = widget.getMarkerPosition();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoadingWidget(),
                  ),
                );
                await UserController.instance
                    .updateHomeground(
                  widget.userDoc['uid'],
                  newPosition.latitude,
                  newPosition.longitude,
                )
                    .then((result) {
                  if (result) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LandingPage(),
                      ),
                      (route) => false,
                    );
                  } else {
                    Get.snackbar(
                      'ERROR',
                      'updateHomeground error',
                      duration: const Duration(seconds: 5),
                      onTap: (snackBar) {
                        print('updateHomeground error');
                      },
                      backgroundColor: Colors.redAccent,
                      snackPosition: SnackPosition.BOTTOM,
                      titleText: const Text(
                        'updateHomeground error',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                    print('updateHomeground error');
                    Navigator.pop(context);
                  }
                });
              }
            },
            label: 'update HOMEGROUND',
            btnColor: (widget.markers.isEmpty)
                ? global.secondaryColor
                : global.primaryColor,
            txtColor: Colors.white,
          )
        ],
      ),
    );
  }
}
