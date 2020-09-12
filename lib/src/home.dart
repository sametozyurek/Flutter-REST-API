import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:post_api/src/get-users.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  apiCall() async {
    String userName = userNameController.text;
    String password = passwordController.text;
    String url = 'http://10.0.2.2:8080/User/add';
    Map data = {
      'userName': userName,
      'password': password,
    };
    var body = json.encode(data);
    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
    if (response.statusCode == 200) {
      print("connection successed");
    } else {
      print("connection failed");
    }
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final userNameTextField = TextField(
      controller: userNameController,
      autofocus: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8.0),
          hintText: 'Enter your username',
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );

    final passwordTextField = TextField(
      controller: passwordController,
      obscureText: true,
      autofocus: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 8.0),
          hintText: 'Enter your password',
          hintStyle: TextStyle(color: Colors.white),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
    );

    final postValidations = RaisedButton(
      autofocus: false,
      child: Text("Send username and password"),
      color: Colors.white,
      elevation: 8.0,
      onPressed: () {
        apiCall();
      },
    );

    final fetchAllUser = RaisedButton(
        autofocus: false,
        child: Text("Show All Users"),
        color: Colors.white,
        elevation: 8.0,
        onPressed: () {
          return Navigator.push(
              context, MaterialPageRoute(builder: (context) => GetAllUsers()));
        });
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: Center(
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            width: 190.0,
            child: ListView(
              padding: EdgeInsets.all(12),
              shrinkWrap: true,
              children: <Widget>[
                userNameTextField,
                passwordTextField,
                Padding(padding: EdgeInsets.only(top: 12.0)),
                postValidations,
                Padding(padding: EdgeInsets.only(top: 12.0)),
                fetchAllUser,
              ],
            ),
          ),
        ));
  }
}
