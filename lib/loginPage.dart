import 'dart:convert';
import 'package:demoflutterloginlogout/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.lightBlue,
          Colors.teal,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: <Widget>[
                headerSection(),
                inputSelction(),
                bottomSelection()
              ],
            ),
    ));
  }

  Container headerSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container inputSelction() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        children: <Widget>[
          txtEmail("Email", Icons.email),
          SizedBox(
            height: 30.0,
          ),
          txtPassword("Password", Icons.lock),
        ],
      ),
    );
  }

  Container bottomSelection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: RaisedButton(
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          performLogin(txtEmailController.text, txtPasswordController.text);
        },
        color: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text(
          "LOGIN",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  TextFormField txtEmail(String title, IconData iconData) {
    return TextFormField(
      controller: txtEmailController,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(iconData)),
    );
  }

  TextFormField txtPassword(String title, IconData iconData) {
    return TextFormField(
      controller: txtPasswordController,
      obscureText: true,
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: Colors.white70),
          icon: Icon(iconData)),
    );
  }

  TextEditingController txtEmailController = new TextEditingController();
  TextEditingController txtPasswordController = new TextEditingController();

  performLogin(String email, String password) async {
    Map data = {'email': email, 'password': password};
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.post("http://127.0.0.1:8000/login", body: data);
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);
      setState(() {
        _isLoading = false;
        sharedPreferences.setString("token", jsonData['token']);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => MainPage()),
            (Route<dynamic> route) => false);
      });
    } else {
      print(response.body);
    }
  }
}
