// HomeScreen.dart

import 'package:flutter/material.dart';

import 'package:probable_pancake/utils/components.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    CustomComponents cmp = new CustomComponents(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        drawer: cmp.getDrawer(),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                        child: RaisedButton(
                            child: Text('Go to Debug Screen'),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, '/debug');
                            }
                        )
                    )
                )
            ),
          ],
        ),
    );
  }
}