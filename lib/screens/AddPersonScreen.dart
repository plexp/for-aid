// AddPersonScreen.dart

import 'package:flutter/material.dart';

import 'package:probable_pancake/utils/components.dart';

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
    String tagData;
    tagData = "test";
    return tagData;
  }
}