import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:insightify/screens/login_page.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;
import 'package:bcrypt/bcrypt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

final nameController = TextEditingController();
final passwordController = TextEditingController();
final emailController = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  String? userName;
  String? password;
  String? email;
  // TextInputControl username = TextInputControl
  // mongodb.Db? _db;
  static var usercollection;
  mongodb.Db? db;
  @override
  void initState() {
    super.initState();

    // db = mongodatabase.connect() as mongodb.Db?;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#283B71"),
        body: _registerUI(context),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5.2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                //topLeft: Radius.circular(100),
                //topRight: Radius.circular(150),
                bottomRight: Radius.circular(100),
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Welcome To Insightify!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: HexColor("#283B71"),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 30, top: 50),
            child: Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    border: InputBorder
                        .none, // Removes the underline when not focused
                    focusedBorder:
                        InputBorder.none, // Removes the underline when focused
                    enabledBorder:
                        InputBorder.none, // Removes the underline when enabled
                    hintText: 'username',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  obscureText: hidePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                      border: InputBorder
                          .none, // Removes the underline when not focused
                      focusedBorder: InputBorder
                          .none, // Removes the underline when focused
                      enabledBorder: InputBorder
                          .none, // Removes the underline when enabled
                      hintText: 'password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          color: Colors.white.withOpacity(0.7),
                          icon: Icon(hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    border: InputBorder
                        .none, // Removes the underline when not focused
                    focusedBorder:
                        InputBorder.none, // Removes the underline when focused
                    enabledBorder:
                        InputBorder.none, // Removes the underline when enabled
                    hintText: 'email',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () async {
                // insert(data);
                setState(() {
                  userName = nameController.text;
                  password = passwordController.text;
                  email = emailController.text;
                });
                // insertdata(userName!, password!, email!);
                // final response =
                //     await http.get(Uri.parse('http://192.168.0.102:5555/'));
                // print(response);
                registerUser();
                // fetchData();
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "OR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 25,
              ),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white, fontSize: 14.0),
                  children: <TextSpan>[
                    const TextSpan(
                      text: 'already registered? ',
                    ),
                    TextSpan(
                      text: 'Log in',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ));
                        },
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  String? validateEmail(String email) {
    final emailRegex = RegExp(
        r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(email)) {
      return 'Invalid email format';
    }
    return null; // No error
  }

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    // Add more validation rules as needed (e.g., minimum length)
    //else : // No error
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    // Add more validation rules as needed (e.g., minimum length, complexity)
    return null; // No error
  }

  Future<void> registerUser() async {
    var userData = {
      'username': nameController.text,
      'password': passwordController.text,
      'email': emailController.text,
    };

    final emailError = validateEmail(emailController.text);
    // final usernameError = validateUsername(nameController.text);
    // final passwordError = validatePassword(passwordController.text);
    if (emailError != null) {
      // Show error messages to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$emailError',
          ),
        ),
      );
      return;
    }

    var jsonData = jsonEncode(userData);
    try {
      var response = await http.post(
        Uri.parse('http://192.168.0.106:5000/register'),
        // Uri.parse('http://localhost:62829/'),
        headers: {
          'Content-Type': 'application/json',
          // 'content-Type':'',
        },
        body: jsonData,
      );

      if (response.statusCode == 406) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("BRO PLEASE FILL OUT ALL THE DETAILS FIRST!!!!")));
      }
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("BRO TRY USING A DIFFERENT EMAIL OR USERNAME!")));
      } else if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User registered successfully!")));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ));
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } on Exception catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Registration failed. Please try again later.' + e.toString())),
      );
    }
  }
}
