// AddPersonScreen.dart

import 'package:flutter/material.dart';

import 'package:probable_pancake/utils/components.dart';

import 'package:barcode_scan/barcode_scan.dart';

class AddPersonScreen extends StatefulWidget {
  AddPersonScreen({Key key}) : super(key: key);
  _AddPersonScreenState createState() => _AddPersonScreenState();
}
class _AddPersonScreenState extends State<AddPersonScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('AddPerson Screen'),
        ),
        drawer: cmp.getDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                        child: Text("NFC Test")
                    )
                )
            ),
            FutureBuilder(
              future: this.getData(),
              builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? Text(snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },

            ),
          ],
        ),
    );
  }

  Future<String> getData() async {
    try {
      String barcode = await BarcodeScanner.scan();
      return barcode;
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
          return 'The user did not grant the camera permission!';
      } else {
        return 'Unknown error: $e'
      }
    } on FormatException{
      return 'null (User returned using the "back"-button before scanning anything. Result)';
    } catch (e) {
      return 'Unknown error: $e';
    }
  }
}