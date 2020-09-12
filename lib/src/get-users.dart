import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class API {
  static Future getUsers() {
    var url = 'http://10.0.2.2:8080/User/';
    return http.get(url);
  }
}

class User {
  String userName;
  String password;

  User({this.userName, this.password});

  factory User.fromJson(Map json) {
    return User(
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map toJson() {
    return {'userName': userName, 'password': password};
  }
}

class GetAllUsers extends StatefulWidget {
  static String tag = 'fetch-users';
  @override
  _GetAllUsersState createState() => _GetAllUsersState();
}

class _GetAllUsersState extends State<GetAllUsers> {
  var users = new List<User>();

  _fetchUser() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users List"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(users[index].userName + " " + users[index].password),
              );
            }),
      ),
    );
  }
}
