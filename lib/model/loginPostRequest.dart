import 'dart:convert';
import 'dart:async';
import 'package:demoflutterloginlogout/app_screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPostRequest {
  Future<void> performLogin(BuildContext context,String email,String password,String URI) async {
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
     debugPrint('BUTTON CLICKED:>>>>>>> 2'+ responseBody.toString());
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       action: SnackBarAction(
         label: 'Okie',
         onPressed: (){
           ScaffoldMessenger.of(context).hideCurrentSnackBar();
         },
       ),
       content: Text("Login Failed"),
     ));
     throw new Exception("Error while fetching data");
   }else if(statusCode==200){
     debugPrint('BUTTON CLICKED:>>>>>>> 3'+ responseBody.toString());
     jsonData = json.decode(response.body);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
       action: SnackBarAction(
         label: 'Okie',
         onPressed: (){
           ScaffoldMessenger.of(context).hideCurrentSnackBar();
           sharedPreferences.setString("token", jsonData['token']);
           Navigator.of(context).pushAndRemoveUntil(
               MaterialPageRoute(builder: (BuildContext context) => MyHomescreen()), (Route<dynamic> route) => false);
         },
       ),
       content: Text("Login Sucess"),
     ));
   }
    return CircularProgressIndicator();
  }
}