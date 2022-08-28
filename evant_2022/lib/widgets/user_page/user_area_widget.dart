import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import 'dart:async';

import '../../widgets/responsive_layout_widget.dart';

import '../../controllers/global_controller.dart' as global;

class UserAreaWidget extends StatefulWidget {
  final Map myUserDoc;
  final Map userDoc;
  const UserAreaWidget({
    Key? key,
    required this.userDoc,
    required this.myUserDoc,
  }) : super(key: key);

  @override
  State<UserAreaWidget> createState() => _UserAreaWidgetState();
}

class _UserAreaWidgetState extends State<UserAreaWidget> {
  late CameraPosition initCameraPosition;
  late Set<Marker> markerSet;

  Completer<GoogleMapController> controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void addMarker(LatLng point) {
    final MarkerId markerId = MarkerId('homeground');
    final Marker marker = Marker(
      markerId: markerId,
      position: point,
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  bool amIfollowing() {
    print(widget.myUserDoc['following']);
    if (widget.myUserDoc['following'].contains(widget.userDoc['uid'])) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
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
  Widget build(BuildContext context) {
    return ResponsiveLayoutWidget(
      mobileVer: UserAreaMobileWidget(
        initialCameraPosition: initCameraPosition,
        controller: controller,
        markers: markers,
        following: amIfollowing(),
      ),
    );
  }
}

// ----------------------- MOBILE -------------------- //

class UserAreaMobileWidget extends StatefulWidget {
  final bool following;
  final Completer<GoogleMapController> controller;
  final CameraPosition initialCameraPosition;
  final Map<MarkerId, Marker> markers;
  const UserAreaMobileWidget({
    Key? key,
    required this.initialCameraPosition,
    required this.controller,
    required this.markers,
    required this.following,
  }) : super(key: key);

  @override
  State<UserAreaMobileWidget> createState() => _UserAreaMobileWidgetState();
}

class _UserAreaMobileWidgetState extends State<UserAreaMobileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .75,
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
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            width: MediaQuery.of(context).size.width * .85,
            child: (widget.following)
                ? GoogleMap(
                    initialCameraPosition: widget.initialCameraPosition,
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      widget.controller.complete(controller);
                    },
                    markers: Set<Marker>.of(widget.markers.values),
                  )
                : const Center(
                    child: Text(
                    'Must be following this user to see the area map',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
          )
        ],
      ),
    );
  }
}
