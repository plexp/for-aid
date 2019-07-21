// main.dart

import 'package:flutter/material.dart';
import 'package:probable_pancake/screens/MapScreen.dart';
import 'package:probable_pancake/screens/PersonDetailScreen.dart';

import 'screens/HomeScreen.dart';
import 'screens/DebugScreen.dart';
import 'screens/AddPersonScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.pink),
        routes: <String, WidgetBuilder> {
          '/' : (BuildContext context) => HomeScreen(),

          '/people/add' : (BuildContext context) => AddPersonScreen(),
          '/people/detail' : (BuildContext context) => PersonDetailScreen(),
          '/people/map' : (BuildContext context) => MapScreen(),

          '/debug' : (BuildContext context) => DebugScreen(),
        },
    );
  }
}
