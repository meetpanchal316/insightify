import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:insightify/main.dart';
import 'package:insightify/screens/analytics.dart';
import 'package:insightify/screens/dashboard.dart';
import 'package:insightify/screens/logingoogle.dart';
import 'package:insightify/screens/settings.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:sidebarx/sidebarx.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Future<void> checkLoginStatus(bool login) async {
  final prefs = await SharedPreferences.getInstance();
  final storedToken = prefs.getString('jwtToken');

  if (storedToken != null) {
    // User is logged in, navigate to home page
    login = true;
  } else {
    // User is not logged in, navigate to login page
    login = false;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String? accessToken;
  String? _username;
  String? _profileImageUrl;
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _items = [
    {'title': 'DASHBOARD', 'icon': Icons.home},
    {'title': 'ANALYTICS', 'icon': Icons.analytics},
    {'title': 'PREDICTIONS', 'icon': Icons.batch_prediction_sharp},
    {'title': 'REPORTS', 'icon': Icons.report},
    {'title': 'SETTINGS', 'icon': Icons.settings},
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? _jwtToken;

  @override
  void initState() {
    super.initState();
    _loadUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        // centerTitle: true,
        title: const Text("INSIGHTIFY"),
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(_profileImageUrl!),
                    ),
                    Expanded(
                        child: Text(
                            style: TextStyle(fontSize: 20),
                            " Hey!! $_username "))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(_items[index]['icon']),
                    title: Text(_items[index]['title']),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        Navigator.pop(context); // Close the drawer
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: buildbody(),
    );
  }

  // Future<void> _signOut() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove('authToken'); // Remove authentication token
  //   // Clear other user data (if applicable)
  //   prefs.remove('userData');
  //   prefs.remove('preferences');
  //   prefs.remove('username');
  //   prefs.remove('email');
  //   prefs.remove('profileImageUrl');
  //   googleSignIn.signOut();
  //   // ...
  //   // Navigate to login page
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const loginwgoogle(),
  //       ));
  // }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _jwtToken = prefs.getString('jwtToken');
    });
  }

  Future<void> checkLoginStatus() async {
    await _loadToken();

    // Navigate to home page if logged in, login page otherwise
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _jwtToken != null
              ? const MyHomePage(title: "Analytics")
              : const loginwgoogle(),
        ));
  }
  //  Future<void> _signOut() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.remove('jwtToken');
  //   setState(() {
  //     _jwtToken = null;
  //   });
  //   // Navigate to login page
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => loginwgoogle()),
  //   );
  // }

  Future<void> _loadUserdata() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      // _email = prefs.getString('email') ?? '';
      _profileImageUrl = prefs.getString('profileImageUrl') ?? '';
    });
  }

  // Future<void> _loadUsername() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _username = prefs.getString('username');
  //   setState(() {});
  // }

  // Future<void> _loademail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _email = prefs.getString('email');
  //   setState(() {});
  // }

  // Future<void> _loadProfileImageUrl() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _profileImageUrl = prefs.getString('profileImageUrl');
  //   setState(() {});
  // }

  Widget buildbody() {
    switch (_selectedIndex) {
      case 0:
        return const dashboard();
      case 1:
        return Analytics(accessToken: authToken ?? '');
      case 4:
        return const settings();

      default:
        return const Placeholder();
    }
  }

}
