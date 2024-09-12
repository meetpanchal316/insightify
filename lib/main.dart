import 'package:flutter/material.dart';
import 'package:insightify/screens/home.dart';
import 'package:insightify/screens/login_page.dart';
import 'package:insightify/screens/register_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

Widget _defaultHome = const LoginPage();
bool isloggedin = false;
void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // Get result of the login function.
  runApp(const MyApp());
}

var bodyColor = Color.fromARGB(255, 24, 24, 24);
var appbarcolor = const Color.fromARGB(255, 0, 0, 0);
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(background: bodyColor),
        useMaterial3: true,
      ),
      home: const LoginPage(),

      // routes: {
      //   '/': (context) => _defaultHome,
      //   '/home': (context) => const MyHomePage(
      //         title: "Analytics",
      //       ),
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      // },
    );
  }

  Future<bool> verifySessionToken(String sessionToken) async {
    // Implement your logic to verify the session token against your server-side data
    // ...
    return tru; // Replace with your actual verification logic
  }
}
