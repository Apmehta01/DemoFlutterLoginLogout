import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SignUp',
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
      theme: ThemeData(
        accentColor: Colors.white70,
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passwordControler = new TextEditingController();
  TextEditingController nickNameControler = new TextEditingController();
  bool isEmail = false,isPassword=false,isNickName=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [headerSection(), inputSection(), buttonSection()],
        ),
      ),
    );
  }
  /**
   * Name : headerSection
   * <br> Purpose : This method contains design of header section.
   */
  Widget headerSection() {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          children: [
            Container(
              child: Text(
                'Signup',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(5.0, 5.0),
                        blurRadius: 3.0,
                        color: Colors.grey,
                      ),
                    ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Text(
                '.',
                style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue),
              ),
            )
          ],
        ));
  }

  /**
   * Name : inputSection
   * <br> Purpose :This method contains ontains design of Textfield/Edittext section.
   */
  Widget inputSection() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          TextFormField(
            controller: emailControler,
            decoration: InputDecoration(
              labelText: 'EMAIL',
              errorText: isEmail ? 'Please enter valid E-Mail' : null,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue)),
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: passwordControler,
            decoration: InputDecoration(
              labelText: 'PASSWORD',
              errorText: isPassword ? 'Please enter valid Password' : null,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue)),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: nickNameControler,
            decoration: InputDecoration(
              labelText: 'NICK NAME',
              errorText: isNickName ? 'Please enter valid Nickname' : null,
              labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue)),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          SizedBox(height: 40.0)
        ],
      ),
    );
  }

  /**
   * Name : buttonSection
   * <br> Purpose : contains design of button section.
   */
  Widget buttonSection() {
    return Container(
        margin: EdgeInsets.only(left: 75.0, right: 75.0),
        child: Column(
          children: [
            Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: Colors.lightBlueAccent,
                color: Colors.lightBlue,
                elevation: 7.0,
                child: OutlineButton(
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  onPressed: () {
                    setState(() {
                      emailControler.text.isEmpty ? isEmail = true : isEmail = false;
                      passwordControler.text.isEmpty ? isPassword= true : isPassword = false;
                      nickNameControler.text.isEmpty ? isNickName= true : isNickName = false;
                    });
                  },
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              height: 40.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      style: BorderStyle.solid,
                      width: 1.0),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Text('Go Back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ));
  }

  /**
   * Name : headerSection
   * <br> Purpose : contains design of bottom section.
   */
  Widget bottomSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New User?',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        SizedBox(
          width: 5.0,
        ),
        InkWell(
          onTap: () {},
          child: Text(
            'Register',
            style: TextStyle(
                color: Colors.lightBlueAccent,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
