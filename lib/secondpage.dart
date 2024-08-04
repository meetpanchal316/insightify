import 'package:flutter/material.dart';
import 'package:insightify/main.dart';

class secondpage extends StatefulWidget {
  const secondpage({super.key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      // backgroundColor: bodyColor,
      appBar: AppBar(
        backgroundColor: appbarcolor,
        title: Text("secondpage")
      ),
    );
  }
}
