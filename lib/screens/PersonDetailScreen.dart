// PersonDetailScreen.dart

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:probable_pancake/utils/components.dart';

import 'package:barcode_scan/barcode_scan.dart';

import 'package:probable_pancake/utils/send_data_prepare.dart';

class PersonDetailScreen extends StatefulWidget {
  PersonDetailScreen({Key key}) : super(key: key);
  _PersonDetailScreenState createState() => _PersonDetailScreenState();
}
class _PersonDetailScreenState extends State<PersonDetailScreen> {
  final idInputController = TextEditingController();
  String barcode;

  @override
  void dispose() {
    idInputController.dispose();
    super.dispose();
  }

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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //TODO retrieve info
            int id = int.parse(idInputController.text);
            
            Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailScreen2(personId: id,))); //TODO retrieve name and location
          },
          tooltip: 'Get Person Detail',
          child: Icon(Icons.search),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                        child: Text("Get Person Detail")
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
                        ],)
                      ),
          ],
        ),
    );
  }

  void getData() async {
     try {
      String barcode = await BarcodeScanner.scan();
      setState(() => idInputController.text = this.barcode = barcode);
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



class PersonDetailScreen2 extends StatelessWidget {
  final int personId;
  final String firstName;
  final String lastName;
  final double latitude;
  final double longitude;

  const PersonDetailScreen2({Key key, @required this.personId, this.firstName, this.lastName, this.latitude, this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('AddPerson Screen'),
        ),
        drawer: cmp.getDrawer(),
        body: Container(
          child: Column(children: <Widget>[
            Center(child: Text("Person details:")),
            Center(child: Text("Person ID: " + this.personId.toString())),
          ],)
        ),

    );
    }
}