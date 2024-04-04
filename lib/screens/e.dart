import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:new_money/screens/home/entry.dart';


import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DataPlot extends StatefulWidget {
  const DataPlot({super.key});

  @override
  State<DataPlot> createState() => _DataPlotState();
}

class _DataPlotState extends State<DataPlot> {
  late List<FlSpot> _data;
  final bool _showDot = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  double calculateMaxY() {
    if (_data.isEmpty || _data.every((spot) => spot.y == 0)) {
      return 0;
    } else {
      final maxValue = _data.map((spot) => spot.y).reduce(max);
      return maxValue * 1.4; 
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getStringList('dataList') ?? List.filled(7, '0');
    _updateData(savedData);
  }

  Future<void> _saveData(List<String> newData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('dataList', newData);
  }

  // void _updateData(List<String> newData) {
  //   setState(() {
  //     _data = List.generate(newData.length,
  //         (index) => FlSpot(index.toDouble(), double.parse(newData[index])*0.000288962));
  //   });
  // }
  void _updateData(List<String> newData) {
    setState(() {
      _data = List.generate(
          newData.length,
          (index) => FlSpot(
              index.toDouble(),
              double.parse((double.parse(newData[index]) * 0.000288962)
                  .toStringAsFixed(6))));
    });
  }

  void _openDataEntryScreen() async {
    print("Opening DataEntryScreen");
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DataEntryScreen()),
    );

    if (result != null) {
      _saveData(result);
      _updateData(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: 340,
                    height: 177,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 32,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 230,
                          top: 0,
                          child: TextButton(
                            onPressed: () => _openDataEntryScreen(),
                            child: Text(
                              'Update Data',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                          child: linechart(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//linechart widget below
  LineChart linechart() {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((LineBarSpot spot) {
                if (spot == null) {
                  return null;
                }
                return LineTooltipItem(
                  '${spot.y.toStringAsFixed(6)} ton',
                  const TextStyle(color: Color.fromARGB(255, 56, 211, 8)),
                );
              }).toList();
            },
          ),
          touchSpotThreshold: Checkbox.width * 2,
          handleBuiltInTouches: true, 
        ),
        gridData: FlGridData(show: false),
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 30,
              //getTitlesWidget: bottomTitleWidgets,
              interval: 1,
            ),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 30,
              //getTitlesWidget: bottomTitleWidgets,
              interval: 1,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 30,
              //getTitlesWidget: bottomTitleWidgets,
              interval: 1,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: bottomTitleWidgets,
              interval: 1,
            ),
          ),
        ),
        //showingTooltipIndicators: List.empty(growable: true),

        borderData: FlBorderData(
          show: false,
          border: Border.all(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 1,
          ),
        ),

        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: calculateMaxY(),
        lineBarsData: [
          LineChartBarData(
            spots: _data,
            isCurved: false,
            preventCurveOverShooting: true,
            shadow: Shadow(
              color: Color.fromARGB(255, 197, 250, 148),
            ),
            //belowBarData: BarAreaData(show: true,color: Color.fromARGB(255, 196, 248, 182)),
            color: Color.fromARGB(255, 0, 244, 57),
            dashArray: [3, 1],
            dotData: FlDotData(
              show: _showDot,
              checkToShowDot: (spot, bardata) {
                
                return spot == _data.last;
              },
            ),
          ),
        ],
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 0,
              // Y-coordinate above bottomTitles
              color: Colors.grey,
              strokeWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 9,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Day 1', style: style);
      break;

    case 1:
      text = const Text('Day 2', style: style);
      break;
    case 2:
      text = const Text('Day 3', style: style);
      break;
    case 3:
      text = const Text('Day 4', style: style);
      break;
    case 4:
      text = const Text('Day 5', style: style);
      break;
    case 5:
      text = const Text('Day 6', style: style);
      break;
    case 6:
      text = const Text('Day 7', style: style);
      break;
    default:
      text = const Text('Fri', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
