// AddPersonScreen.dart

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:probable_pancake/utils/components.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:geolocator/geolocator.dart';

import 'package:probable_pancake/utils/send_data_prepare.dart';

class AddPersonScreen extends StatefulWidget {
  final bool androidFusedLocation = false;
  AddPersonScreen({Key key}) : super(key: key);
  _AddPersonScreenState createState() => _AddPersonScreenState();
}
class _AddPersonScreenState extends State<AddPersonScreen> {
  final idInputController = TextEditingController();
  final firstNameInputController = TextEditingController();
  final lastNameInputController = TextEditingController();
  double latitude;
  double longitude;
  Position _lastKnownPosition;
  Position _currentPosition;

  String barcode;

  @override
  void dispose() {
    idInputController.dispose();
    firstNameInputController.dispose();
    lastNameInputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initLastKnownLocation();
    _initCurrentLocation();
  }

  Future<void> _initLastKnownLocation() async {
    Position position;
    try {
      final Geolocator geolocator = Geolocator()
        ..forceAndroidLocationManager = !widget.androidFusedLocation;
      position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.best);
    } on PlatformException {
      position = null;
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _lastKnownPosition = position;
    });
  }

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
  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('AddPerson Screen'),
        ),
        drawer: cmp.getDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO send data
            int id = int.parse(idInputController.text);
            String firstName = firstNameInputController.text;
            String lastName = lastNameInputController.text;
            double latitude = _currentPosition.latitude;
            double longitude = _currentPosition.longitude;
            AddScan send = new AddScan(id: id, first_name: firstName, last_name: lastName, latitude: latitude, longitude: longitude);
            send.sendRequest();
            idInputController.text = "";
            firstNameInputController.text = "";
            lastNameInputController.text = "";
          },
          tooltip: 'Add this person',
          child: Icon(Icons.add),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                        child: Text("Add Person")
                    )
                )
            ),
            Container(
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: RaisedButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                splashColor: Colors.blueGrey,
                                onPressed: getData,
                                child: const Text('Add ID from QR')
                            ),
                          ),
                          Center(
                            child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter a ID'
                                  ),
                                  controller: idInputController,
                                )
                          ),
                          Center(
                            child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter first name'
                                ),
                                  controller: firstNameInputController,
                            )
                          ),
                          Center(
                            child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter last name'
                                ),
                                  controller: lastNameInputController,
                            )
                          ),
                          Center(
                            child: Text("Latitude: " + _currentPosition.latitude.toString())
                          ),
                          Center(
                            child: Text("Longitude: " + _currentPosition.longitude.toString()) 
                          )

                        ],)
                      ),
          ],
        ),
    );
  }

  void getData() async {
     try {
      String barcode = await BarcodeScanner.scan();
      setState(() {idInputController.text = this.barcode = barcode; this.latitude = _currentPosition.latitude; this.longitude = _currentPosition.longitude;});
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          idInputController.text = this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => idInputController.text = this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => idInputController.text = this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => idInputController.text = this.barcode = 'Unknown error: $e');
    }
  }
}