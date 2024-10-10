import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:insightify/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:googleapis_auth/auth_io.dart';

class loginwgoogle extends StatefulWidget {
  const loginwgoogle({super.key});

  @override
  State<loginwgoogle> createState() => _loginwgoogleState();
}

String? authToken;

GoogleSignIn googleSignIn = GoogleSignIn(scopes: <String>[
  'https://www.googleapis.com/auth/youtube.readonly',
  'email',
  'profile',
]);

class _loginwgoogleState extends State<loginwgoogle> {
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Get the access token here
        authToken = googleAuth.accessToken;
        // Save the token only if it's not null
        if (authToken != null) {
          await saveAuthToken(authToken); // No need for '!' anymore
        } else {
          // Handle the case where you can't get a token
          print('Error: Unable to obtain authentication token');
          // You might want to show an error message to the user here
        }
        await _saveuserdata(
            googleUser.displayName!, googleUser.email, googleUser.photoUrl!);

        print('Signed in with Google: $authToken');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(title: "title"),
            ));
      }
    } catch (error) {
      print('Error signing in with Google: $error');
      _signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _signInWithGoogle,
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }

  Future<void> _loadAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    authToken = prefs.getString('authToken');
  }

  // Future<void> _saveUsername(String username) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('username', username);
  // }

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
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => loginwgoogle(),
    //     ));
  }

  Future<void> _saveuserdata(
      String username, String email,String profileImageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('email', email);
    prefs.setString('profileImageUrl', profileImageUrl);
  }

  // Future<void> _saveProfileImageUrl(String profileImageUrl) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString('profileImageUrl', profileImageUrl);
  // }

  Future<void> saveAuthToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token ?? '');
  }
}
