import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class sample extends StatefulWidget {
  const sample({super.key});

  @override
  State<sample> createState() => _sampleState();
}

class _sampleState extends State<sample> {
  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              fetchdata();
            },
            child: Text("click")),
      ),
    );
  }

  Future<void> fetchdata() async {
    print('line 34');
    try {
      final response = await get(Uri.parse('http://192.168.0.106:5555/'));
      print('line 37');
      if (response.statusCode == 200) {
        print('line 29 :: ${jsonDecode(response.body)}');
      } else {
        print('line 40');
      }
    } catch (e) {
      print('line 41 :: ' + e.toString());
    }
  }
}
