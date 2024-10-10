import 'package:flutter/material.dart';
import 'package:insightify/screens/home.dart';
import 'package:insightify/screens/login_page.dart';
import 'package:insightify/screens/logingoogle.dart';
import 'package:insightify/screens/register_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // Get result of the login function.
  runApp(const MyApp());
}

var bodyColor = Color.fromARGB(255, 24, 24, 24);
var appbarcolor = const Color.fromARGB(255, 0, 0, 0);
bool _isLoggedIn = false;
Map<String, double> dataMap = {
  "Youtube": 50,
  "Facebook": 20,
  "Instagram": 30,
};
final gradientList = <List<Color>>[
  [
    Color.fromRGBO(234, 38, 24, 1),
    Color.fromRGBO(215, 207, 205, 1),
  ],
  [
    Color.fromRGBO(129, 182, 205, 1),
    Color.fromRGBO(91, 253, 199, 1),
  ],
  [
    Colors.purple,
    Colors.yellow,
    Colors.pink,
    Colors.orange,
    Colors.blue,
  ]
];

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(background: bodyColor),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: "ANALYTICS"),
      );
    }else{
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.dark(background: bodyColor),
          useMaterial3: true,
        ),
        home: const loginwgoogle(),
      );
    }
  }

  Future<void> _loadLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('authToken') ?? false;
  }

  Future<void> _saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
