import 'package:flutter/material.dart';
import 'package:insightify/screens/logingoogle.dart';
import 'package:shared_preferences/shared_preferences.dart';
class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
          onPressed: _signOut,
          child: const Text('signout'),
        ),
          ],
        ),
      ),
    );
  }
  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('authToken'); // Remove authentication token
    // Clear other user data (if applicable)
    prefs.remove('userData');
    prefs.remove('preferences');
    prefs.remove('username');
    prefs.remove('email');
    prefs.remove('profileImageUrl');
    googleSignIn.signOut();
    // ...
    // Navigate to login page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const loginwgoogle(),
        ));
  }
}