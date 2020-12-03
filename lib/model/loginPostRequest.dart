
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'package:progress_dialog/progress_dialog.dart';

class LoginPostRequest {
  Future<void> performLogin(BuildContext context,String email,String password,String URI,ProgressDialog progressdialog)
  async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final uri = URI;
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {'email': email, 'password': password};
    String jsonBody = json.encode(body);
    final encoding = Encoding.getByName('utf-8');
    http.Response response = await http.post(
      uri,
      headers:headers,
      body: jsonBody,
      encoding: encoding,
    );
    int statusCode = response.statusCode;
    String responseBody = response.body;
    var jsonData=null;
    if (statusCode < 200 || statusCode >= 400 || json == null) {
      // debugPrint('BUTTON CLICKED:>>>>>>> 2'+ responseBody.toString());
      progressdialog.hide().then((isHidden) {
        print(isHidden);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.red,
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: Text("Login Failed"),
      ));
      throw new Exception("Error while fetching data");
    }else if(statusCode==200){
      // debugPrint('BUTTON CLICKED:>>>>>>> 3'+ responseBody.toString());
      jsonData = json.decode(response.body);
      progressdialog.hide().then((isHidden) {
        print(isHidden);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'OK',
          onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            sharedPreferences.setString("token", jsonData['token']);
            // debugPrint('BUTTON CLICKED:>>>>>>> 4');
           /* Navigator.pushReplacement(context, MaterialPageRoute<void>(
              builder: (BuildContext context) => MyHomescreen(),
              fullscreenDialog: true,
            ));*/
            // Navigator.of(context).pushAndRemoveUntil(
            //     MaterialPageRoute(builder: (context) => MyHomescreen()), (Route<dynamic> route) => false);
            Navigator.popAndPushNamed(context, '/homescreen');
            // debugPrint('BUTTON CLICKED:>>>>>>> 5');
          },
        ),
        content: Text("Login Sucess"),
      ));
    }
    return CircularProgressIndicator();
  }
}