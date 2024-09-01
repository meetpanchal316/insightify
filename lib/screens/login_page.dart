import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// (Remove import for flutter_login_register_nodejs if not used)
import 'package:insightify/screens/home.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:flutter/gestures.dart';
import 'package:insightify/screens/register_login.dart';
import 'package:http/http.dart' as http;
// import 'package:bcrypt/bcrypt.dart';
// import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isApiCallProcess = false;
  String? userName;
  String? password;
  bool hidePassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(12, 4, 50, 0.475),
        body: loginUI(context),
      ),
    );
  }

  Widget loginUI(BuildContext context) {
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
              "Login",
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
                  controller: _usernameController,
                  decoration: InputDecoration(
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
                  controller: _passwordController,
                  obscureText: hidePassword,
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
          SizedBox(height: 20),
          Center(
            child: FormHelper.submitButton(
              "Login",
              () {
                setState(() {
                  userName = _usernameController.text;
                  password = _passwordController.text;
                });

                login();
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
                      text: 'Dont have an account? ',
                    ),
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
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

  Future<void> login() async {
    var userData = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };
    var jsonData = jsonEncode(userData);

    try {
      var response = await http.post(
        Uri.parse('http://192.168.0.106:5000/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      if (response.statusCode == 406) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("BRO PLEASE FILL OUT ALL THE DETAILS FIRST!!!!")));
      }
      else if(response.statusCode==401){
        if(response =="wrong password bro!!"){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("BRO YOU LOOK NEW HERE CONSIDER REGISTRING FIRST!!!!")));
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("WRONG PASSWORD BRO!!!!")));
        }
        
      }
      else if (response.statusCode == 200) {
        final responseData =
            jsonDecode(response.body); // Parse the JSON response
        print("response body : $responseData");

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("LOGGED IN SUCCESSFULLY")));
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(title: "analytics"),
              ));
        }
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } on Exception catch (e) {
      print('An error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again later.')),
      );
    }
  }
}
