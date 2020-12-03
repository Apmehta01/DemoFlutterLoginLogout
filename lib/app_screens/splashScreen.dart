import 'dart:async';
import 'package:demoflutterloginlogout/app_screens/homeScreen.dart';
import 'package:demoflutterloginlogout/app_screens/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplashScreen(),
      routes: <String, WidgetBuilder> {
        '/loginscreen': (BuildContext context) => new LoginScreen(),
        '/homescreen' : (BuildContext context) => new DashBoardScreen(),
        '/signupscreen' : (BuildContext context) => new SignUpPage(),
      },
      theme: ThemeData(
        accentColor: Colors.lightBlueAccent,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreen createState() => _MySplashScreen();
}
class _MySplashScreen extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    checkToken();
   }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }

  /**
   * Name : checkToken
   * <br> Purpose : Contains logic of checking token during run time.
   */
  checkToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences = await SharedPreferences.getInstance();
    String sToken="";
    sToken = sharedPreferences.getString("token");
    if(sToken!=null && sToken.trim()!=''){
      // debugPrint('TOKEN :>>>>>>> TRUE');
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  DashBoardScreen()
              )
          )
      );
    }else{
      // debugPrint('TOKEN :>>>>>>> FALSE');
      Timer(Duration(seconds: 3),
              ()=>Navigator.pushReplacement(context,
              MaterialPageRoute(builder:
                  (context) =>
                  LoginScreen()
              )
          )
      );
    }
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:LoginPage()
      ),
    );
  }
}