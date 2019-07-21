import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:probable_pancake/utils/send_data_prepare.dart';
import 'package:probable_pancake/utils/components.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';


void main() => runApp(MapScreen());

class MapScreen extends StatefulWidget {
  final bool androidFusedLocation = false;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Position _lastKnownPosition;
  Position _currentPosition;


  @override
  void initState() {

    super.initState();

    _initLastKnownLocation();
    _initCurrentLocation();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _currentPosition = null;
    });

    _initLastKnownLocation();
    _initCurrentLocation();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initLastKnownLocation() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !widget.androidFusedLocation;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }

    setState(() {
      _lastKnownPosition = position;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  _initCurrentLocation() {
    Geolocator()
      ..forceAndroidLocationManager = !widget.androidFusedLocation
      ..getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      ).then((position) {
        if (mounted) {

          setState(() => _currentPosition = position);
        }
      }).catchError((e) {
        //
      });
  }

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    List<AddScan> people = await AddScan().getPeople();
    setState(() {
      _markers.clear();
      for (final person in people) {
        final marker = Marker(
          markerId: MarkerId(person.id.toString()),
          position: LatLng(person.latitude, person.longitude),
          infoWindow: InfoWindow(
            title: person.id.toString(),
            snippet: person.first_name + " " + person.last_name,
          ),
          onTap: () {
          }
        );
        _markers[person.id.toString()] = marker;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return FutureBuilder<GeolocationStatus>(
        future: Geolocator().checkGeolocationPermissionStatus(),
        builder:
            (BuildContext context, AsyncSnapshot<GeolocationStatus> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == GeolocationStatus.denied) {
            return const Center(child: Text('access denied')); //TODO handle access denied
          }

          return Scaffold(
              appBar: AppBar(
                title: const Text('People Locations'),
              ),
              body: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(40.4468825758702, -3.694507890552619),
                  zoom: 16,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: _markers.values.toSet(),
              ),
              endDrawer: cmp.getDrawer()
          );
        });

  }
}