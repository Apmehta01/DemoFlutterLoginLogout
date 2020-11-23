import 'dart:ui';
import 'package:demoflutterloginlogout/app_screens/loginPage.dart';
import 'package:demoflutterloginlogout/app_screens/randomUserList.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'jobListScreen.dart';

  void main() {
    runApp(DashBoardScreen());
  }

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      drawer: setUpDrawer(context),
      body:  Center(
          child: RandomUserList()
      ),
    );
  }
  /**
   * Name : setUpDrawer
   * <br> Purpose : This method is for showing drawer inside the screen.
   */
  Widget setUpDrawer(BuildContext context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Colors.lightBlue,
            ),
            accountName: Text("Arpan Mehta",
              style: TextStyle(
              fontSize: 18.0
            ),),
            accountEmail: Text("arpan.mehta@ftxinfotexh.com",
              style: TextStyle(
                  fontSize: 16.0
              ),),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
              Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.lightBlue
                  : Colors.white,
              child: Icon(
                Icons.person,
                color: Colors.blueGrey,
                size: 50,
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.lock),
            onTap: () {
              // Update the state of the app
              // Then close the drawer
              // Navigator.pop(context);
              showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  /**
   * Name : showLogoutDialogo
   * <br> Purpose : This method is for showing logout dialog.
   */
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
