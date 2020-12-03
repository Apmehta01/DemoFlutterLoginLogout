import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:demoflutterloginlogout/model/loginPostRequest.dart';
import 'dart:async';
import 'package:progress_dialog/progress_dialog.dart';

void main() {
  runApp(new LoginScreen());
}

class LoginScreen extends StatelessWidget {
  final Future post;
  LoginScreen({Key key, this.post}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exploring the Flutter'),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final CREATE_POST_URL = 'https://reqres.in/api/register';
  TextEditingController emailControler = new TextEditingController();
  TextEditingController passwordControler = new TextEditingController();
  bool isEmail = false, isPassword = false;
  ProgressDialog progressdialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanDown: (_) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
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
        ),
      resizeToAvoidBottomPadding: false,
    );
  }

  /**
   * Name : headerSection
   * Purpose : This method contains design of header section.
   */
  Widget headerSection() {
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

  /**
   * Name : inputSection
   * Purpose :This method contains ontains design of Textfield/Edittext section.
   */
  Widget inputSection() {
    return Container(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      child: Column(
        children: [
          TextFormField(
            // validator:validateEmail,
            // onSaved: (String val) {
            //   var _email = val;
            // },
            autofocus: false,
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
            autofocus: false,
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

  /**
   * Name : buttonSection
   * Purpose : contains design of button section.
   */
  Widget buttonSection() {
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
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0)),
                  onPressed: () async {
                    // debugPrint('BUTTON CLICKED:>>>>>>> 1');
                    setState(() {
                      /*Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (BuildContext context) => MyHomescreen()),
                              (Route<dynamic> route) => false);*/

                      performLogin(emailControler, passwordControler);
                      emailControler.text.isEmpty
                          ? isEmail = true
                          : isEmail = false;
                      passwordControler.text.isEmpty
                          ? isPassword = true
                          : isPassword = false;
                    });
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

  /**
   * Name : headerSection
   * Purpose : contains design of bottom section.
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
          onTap: () {
            Navigator.of(context).pushNamed('/signupscreen');
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

  /**
   * Name : performLogin
   * Purpose : contains logic of login.
   */
  Future<void> performLogin(
      [TextEditingController emailControler,
      TextEditingController passwordControler]) async {
    showProgressDialog();
    String email = emailControler.text;
    String pass = passwordControler.text;
    LoginPostRequest loginPostRequest = LoginPostRequest();
    loginPostRequest.performLogin(context, email, pass, CREATE_POST_URL,progressdialog);
  }

  /**
   * Name : showProgressBar
   * Purpose : This method is for showing progressDialog.
   */
  showProgressDialog(){
    progressdialog = new ProgressDialog(context);
    progressdialog.style(
      message: 'Loading.....',
      progressWidget: Transform.scale(
        scale: 0.5,
        child:CircularProgressIndicator(
        ),
      ),
      insetAnimCurve: Curves.easeInOut,
    );
    progressdialog.show();
  }
}

/*String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      debugPrint('ERROR:>>>>>>>');
      return 'Enter Valid Email';
    } else
      debugPrint('ERROR:>>>>>>> 1');
    return null;
  }*/