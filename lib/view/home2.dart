import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apis/res/app_url.dart';
import 'package:http/http.dart' as http;

class Home2 extends StatelessWidget {
  Home2({Key? key}) : super(key: key);

  var data;

  Future<void> getUserApi() async {
    final responce = await http.get(Uri.parse(AppUrl.firstAPi));

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getUserApi(),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(data[1]['name'].toString())],
            ),
          );
        },
      ),
    );
  }
}
