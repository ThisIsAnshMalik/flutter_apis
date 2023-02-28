import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apis/models/user_model.dart';
import 'package:flutter_apis/res/app_url.dart';
import 'package:http/http.dart' as http;

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final responce = await http.get(Uri.parse(AppUrl.firstAPi));
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i as dynamic));
      }
      return userList;
    }
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUserApi(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Loading..."),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Text(snapshot.data![index].name.toString());
                }));
          }
        },
      ),
    );
  }
}
