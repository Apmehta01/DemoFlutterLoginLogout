import 'dart:ui';
import 'package:demoflutterloginlogout/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:demoflutterloginlogout/model/loginPostRequest.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final Future post;
  MyApp({Key key, this.post}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signUpPage': (BuildContext context) => new SignUpPage()
      },
      home: MainPage(),
      theme: ThemeData(
        accentColor: Colors.white70,
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static final CREATE_POST_URL = 'http://reqres.in/api/login';
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passwordControler = new TextEditingController();
  bool isEmail = false,isPassword=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            headerSection(),
            inputSection(),
            buttonSection(),
            bottomSection(),
          ],
        ),
      )
    );
  }

  //Contains design of header section.
  Container headerSection() {
    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello',
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
            Row(
              children: [
                Container(
                  child: Text(
                    'There',
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
                // SizedBox(width: 5.0,),
                Container(
                  child: Text(
                    '.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlue),
                  ),
                )
              ],
            )
          ],
        ));
  }

  //Contains design of Textfield/Edittext section.
  Container inputSection() {

    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          TextField(
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
          TextField(
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
          SizedBox(
            height: 5.0,
          ),
          Container(
            alignment: Alignment(1.0, 0.0),
            padding: EdgeInsets.only(top: 15.0, left: 20.0),
            child: InkWell(
              child: Text(
                'Forgot Password',
                style: TextStyle(
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    decoration: TextDecoration.underline),
              ),
            ),
          ),
          SizedBox(height: 40.0)
        ],
      ),
    );
  }

  //Contains design of button section.
  Container buttonSection() {
    AssetImage assetImage = new AssetImage('assets/images/facebook.png');
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
                  onPressed: ()async {
                    debugPrint('BUTTON CLICKED:>>>>>>> 1');
                    setState(() {
                      emailControler.text.isEmpty ? isEmail = true : isEmail = false;
                      passwordControler.text.isEmpty ? isPassword= true : isPassword = false;
                    });
                    performLogin(emailControler,passwordControler);
                  },
                  child: Center(
                    child: Text(
                      'LOGIN',
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ImageIcon(assetImage),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Center(
                      child: Text(
                        'Log in with facebook',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ));
  }

  //Contains design of bottom layout.
  Row bottomSection() {
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
          onTap: () {
            Navigator.of(context).pushNamed('/signUpPage');
          },
          child: Text(
            'Register',
            style: TextStyle(
                color: Colors.lightBlueAccent,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Future<void> performLogin([TextEditingController emailControler,TextEditingController passwordControler])
  async {
    /*Scaffold.of(context).showSnackBar(SnackBar(
      content: Text("Sending Message"),
    ));*/
    Post newPost = new Post(sEmail: emailControler.text, sPassword: passwordControler.text);
    Post p = await newPost.createPost(context,CREATE_POST_URL,
        body: newPost.toMap());
    print(p.sEmail);
    debugPrint('BUTTON CLICKED:>>>>>>> 2');
  }
}