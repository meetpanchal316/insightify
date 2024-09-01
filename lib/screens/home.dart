import 'package:flutter/material.dart';
import 'package:insightify/main.dart';
import 'package:pie_chart/pie_chart.dart' as charts;
import 'package:pie_chart/pie_chart.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var screenheight =
        MediaQuery.of(context).size.height; // get the size of your screen
    var screenwidth =
        MediaQuery.of(context).size.width; // get the size of your screen

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarcolor,
        // centerTitle: true,
        title: Text("ANALYTICS"),
        automaticallyImplyLeading: false,
      ),
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
            )
          ],
        ),
      ),
    );
  }
}
