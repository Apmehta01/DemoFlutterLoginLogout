import 'dart:ui';
import 'package:demoflutterloginlogout/app_screens/loginPage.dart';
import 'package:demoflutterloginlogout/model/jobModel.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyHomescreen());
}

class MyHomescreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Exploring the Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        drawer: setUpDrawer(context),
        body:  Center(
          child: JobsListView()
        ),
      ),
    );
  }

  // basic lisview.
  Widget getBasicListview() {
    var listview = ListView(
      padding: EdgeInsets.all(15.0),
      children: <Widget>[
        Center(
            child: Text(
          "List of items",
          style: TextStyle(fontSize: 20.0),
        )),
        Container(
          color: Colors.lightBlueAccent,
          height: 5.0,
          margin: EdgeInsets.only(top: 5.0),
        ),
        //It is appear like row
        ListTile(
          //Icon that appears on the left
          leading: Icon(Icons.landscape),
          title: Text('Title of landscape'),
          subtitle: Text('Beatiful view'),
          //Icon that appears on the right
          trailing: Icon(Icons.wb_sunny),
        ),
        ListTile(
          //Icon that appears on the left
          leading: Icon(Icons.laptop_chromebook),
          title: Text('Ubuntu'),
        ),
        ListTile(
          //Icon that appears on the left
          leading: Icon(Icons.phone),
          title: Text('Phone'),
        ),
      ],
    );
    return listview;
  }
  Widget setUpDrawer(BuildContext context){
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              // Navigator.pop(context);
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    AlertDialog alert;
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context, false);
      },
    );
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed:  () async {
        Navigator.pop(context, true);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext ctx) => LoginPage()));
      },
    );

    // set up the AlertDialog
    alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure want to Logout?"),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
