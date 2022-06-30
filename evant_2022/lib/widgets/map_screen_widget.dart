import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/global_controller.dart' as global;

class MapScreenWidget extends StatefulWidget {
  const MapScreenWidget({Key? key}) : super(key: key);

  @override
  State<MapScreenWidget> createState() => _MapScreenWidgetState();
}

class _MapScreenWidgetState extends State<MapScreenWidget> {
  static const _initCameraPosiion =
      CameraPosition(target: LatLng(37.532600, 127.024612), zoom: 11.5);

  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Random rnd = Random();

  void _add(LatLng point) {
    var markerIdVal = rnd.nextInt(1000).toString();
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: point,
      infoWindow: InfoWindow(
        title: markerIdVal,
        snippet: 'test',
      ),
      onTap: () {},
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initCameraPosiion,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(markers.values),
        onTap: _handleTap,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: global.primaryColor,
        foregroundColor: global.secondaryColor,
        onPressed: () => _goToCenter(),
      ),
    );
  }

  Future<void> _goToCenter() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_initCameraPosiion),
    );
  }

  void _handleTap(LatLng point) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Event'),
          content: const Text('Set up event at this location ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _add(point);
                Navigator.pop(context);
              },
              child: const Text(
                'Create',
                style: TextStyle(
                  color: global.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
