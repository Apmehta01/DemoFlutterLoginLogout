import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Post {
  final String sEmail;
  final String sPassword;

  Post({this.sEmail, this.sPassword});

  factory Post.fromJson(Map json) {
    return Post(
      sEmail: json['email'],
      sPassword: json['password'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["email"] = sEmail;
    map["password"] = sPassword;

    return map;
  }
  Future createPost(BuildContext context,String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }else if(statusCode==200){
     /*   Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Login Sucess"),
        ));*/
        debugPrint('BUTTON CLICKED:>>>>>>> 3');
      }
      return Post.fromJson(json.decode(response.body));
    });
  }
}