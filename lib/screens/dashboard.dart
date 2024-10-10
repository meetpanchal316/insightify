import 'package:flutter/material.dart';
import 'package:flutter_titled_container/flutter_titled_container.dart';
import 'package:insightify/main.dart';
import 'package:pie_chart/pie_chart.dart' as charts;
import 'package:pie_chart/pie_chart.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String? _username;
  String? _email;
  String? _profileImageUrl;
  
  @override
  Widget build(BuildContext context) {
    var screenheight =
        MediaQuery.of(context).size.height; // get the size of your screen
    var screenwidth =
        MediaQuery.of(context).size.width; // get the size of your screen
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // PieChart(dataMap: dataMap, chartRadius: screenwidth/2 ,)
              charts.PieChart(
                dataMap: dataMap,
                chartRadius: screenwidth * 0.5,
                centerWidget: Text(
                    style: TextStyle(
                      // fontSize: screenheight * 0.03,
                      color: Color.fromARGB(255, 19, 19, 19),
                    ),
                    "views"),
                animationDuration: Duration(seconds: 3),
                chartValuesOptions: ChartValuesOptions(
                  decimalPlaces: 0,
                  showChartValueBackground: false,
                  showChartValuesInPercentage: true,
                ),
                // gradientList: gradientList,
                colorList: [
                  Color.fromARGB(255, 137, 3, 25),
                  const Color.fromARGB(255, 20, 93, 152),
                  Color.fromARGB(255, 12, 213, 193)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TitledContainer(
                    child: Container(
                      height: screenheight / 4,
                      width: screenwidth / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    title: "data",
                    backgroundColor: Colors.transparent,
                    titleColor: Color.fromARGB(255, 160, 193, 168),
                  ),
                ],
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: Column(
                  children: <Widget>[
                    // Text("subscribers/followers"),
                    // Text("welcome $_username! "),
                    // Text("welcome $_email! "),
                    // CircleAvatar(
                    //   backgroundImage: NetworkImage(_profileImageUrl!),
                    //   radius: 50,
                    // ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
    );
  }
}