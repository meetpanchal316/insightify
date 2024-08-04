import 'package:flutter/material.dart';
import 'package:insightify/secondpage.dart';

void main() {
  runApp(const MyApp());
}

var bodyColor = Color.fromARGB(255, 24, 24, 24);
var appbarcolor = Color.fromARGB(255, 0, 0, 0);

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
      home: const MyHomePage(title: 'ANALYTICS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: Text(widget.title),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // all of the widgets for this page
        ],
      ),
    );
  }
}
