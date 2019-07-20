// DebugScreen.dart

import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Debug Screen'),
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Container(
                height: 80,
                child: Center(
                    child: Container(
                      child: Text("This is debug screen used to access all other screens."),
                    )
                )
            ),
            Container(
                height: 80,
                child: Center(
                    child: Container(
                      child: RaisedButton(
                          child: Text('Go to Home Screen'),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, '/');
                          }
                      ),
                    )
                )
            ),
          ],
        )
    );
  }



}