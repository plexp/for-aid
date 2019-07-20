
import 'package:flutter/material.dart';

class CustomComponents {
  BuildContext context;

  CustomComponents(BuildContext context) {
    this.context = context;
  }

  Drawer getDrawer() {
    context = this.context;
    Drawer drawer = Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Pancake'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Main Screen'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('Debug'),
            onTap: () {
              Navigator.pushNamed(context, '/debug');
            },
          ),
        ],
      ),
    );
    return drawer;
  }

}