import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../sql/db.dart';

class Diagram extends StatefulWidget {
  const Diagram({super.key});

  @override
  State<Diagram> createState() => _DiagramState();
}

class _DiagramState extends State<Diagram> {
  double? _food;
  List<Map<String, dynamic>> _Car = [];
  List<Map<String, dynamic>> _Home = [];
  List<Map<String, dynamic>> _Electricity = [];
  List<Map<String, dynamic>> _Other = [];
  List<_ChartData> data = [];
  late TooltipBehavior _tooltip;
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    _refreshJournals();
    super.initState();
  }

  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final fooddata = await DatabaseHelper.getItem('Food');
    final cardata = await DatabaseHelper.getItem('Car');
    final homedata = await DatabaseHelper.getItem('Home');
    final Electricitydata = await DatabaseHelper.getItem('Electricity');
    final otherdata = await DatabaseHelper.getItem('Other');
    if (fooddata.length >= 1 ||
        cardata.length >= 1 ||
        homedata.length >= 1 ||
        Electricitydata.length >= 1 ||
        otherdata.length >= 1) {
      setState(() {
        data = [
          _ChartData('Food', fooddata.length.toDouble()),
          _ChartData('Car', cardata.length.toDouble()),
          _ChartData('Home', homedata.length.toDouble()),
          _ChartData('Electricity', Electricitydata.length.toDouble()),
          _ChartData('Other', otherdata.length.toDouble()),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          right: 0,
          left: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: height * 0.15,
            color: const Color.fromARGB(255, 56, 182, 121),
            child: const Center(
              child: Text(
                'Char',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 9,
          right: 0,
          left: 0,
          child: Container(
            height: height * 0.65,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: data.isEmpty == true
                ? Center(
                    child: const Text(
                      'No expense has been added yet',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                : SfCircularChart(
                    legend: Legend(isVisible: true),
                    title: ChartTitle(text: 'Total Expense'),
                    series: <CircularSeries>[
                      // Render pie chart
                      PieSeries<_ChartData, String>(
                          dataSource: data,
                          xValueMapper: (_ChartData data, _) => data.x,
                          yValueMapper: (_ChartData data, _) => data.y),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
