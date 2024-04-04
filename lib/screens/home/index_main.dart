import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';
import 'package:new_money/services/auth.dart';
import 'package:new_money/services/database.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  final List<FlSpot> _data = [
    FlSpot(0, 3),
    FlSpot(1, 1),
    FlSpot(2, 4),
    FlSpot(3, 2),
    FlSpot(4, 5),
    FlSpot(5, 3),
    FlSpot(6, 4),
  ];
  bool _showDot = true;
 Future<Map<String, dynamic>?>? userData; 
  final AuthService _auth = AuthService();
  String? firstName;
   String? climateTag;

  String? image;
  


  @override
  void initState() {
    super.initState();
    
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _showDot = !_showDot;
        print('blink');
      });
    });
     Service().getUserData().then((data) {
      setState(() {
        firstName = data?['firstName'];
        climateTag=data?['climateTag'];
        image = data?['image'];
        print('runned');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double ws = MediaQuery.of(context).size.width / 428;
    double hs = MediaQuery.of(context).size.height / 926;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80 * hs,
                    
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child:  CircleAvatar(
                            radius: 24,
                            //backgroundColor: Color(0xFFD9D9D9),
                            backgroundImage: image != null ? NetworkImage(image!) as ImageProvider<Object>? : AssetImage('assets/Account.png') as ImageProvider<Object>?,
                          ),
                        ),
                        Positioned(
                          right: 10 * ws,
                          top: 0,
                          child: Image.asset(
                            'assets/3p.png',
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 0,
                          child: Row(
                            children: [
                              Text(
                                '${climateTag ?? '#CaptainPlanet'}!',
                                style: TextStyle(
                                  color: Color(0xFF2E2E2E),
                                  fontSize: 24,
                                  fontFamily: 'Readex Pro',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              SizedBox(width: 5,),
                              Image.asset(
                          'assets/eco.png',
                          height: 24,
                          width: 24,
                                                    ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 60,
                          top: 28,
                          child: Text(
                            '456K Followers',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 11,
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Search(),
                const SizedBox(
                  height: 15,
                ),
                const Cash(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.width*0.5,
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
                    // child: Padding(
                    //   padding: const EdgeInsets.all(10.0),
                    //   child: linechart(),
                    // ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 160,
                          top: 16,
                          child: Container(
                            // decoration: BoxDecoration(border: Border.all()),
                            width: 54,
                            height: 18,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Opacity(
                                    opacity: 0.25,
                                    child: Container(
                                      width: 54,
                                      height: 18,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFF0364D),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(36),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 8,
                                  top: 5,
                                  child: Container(
                                    width: 38,
                                    height: 8,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: ShapeDecoration(
                                                      color: Color(0xFFF0364D),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(36),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 12,
                                          top: 0,
                                          child: SizedBox(
                                            width: 26,
                                            height: 8,
                                            child: Text(
                                              'LIVE',
                                              style: TextStyle(
                                                color: Color(0xFFF0364D),
                                                fontSize: 8,
                                                fontFamily: 'Readex Pro',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 16,
                          child: Text(
                            'Your Carbon Health',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 14,
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 230,
                          top: 0,
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            child: Text(
                              'See All Stats',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 170,
                        height: 224,
                        child: Card(
                          color: Colors.white,
                          elevation: 0,
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Your Badge",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                    // Other text properties
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/grade.png",
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "You’re now among\nTop 50% of our members.",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                    // Other text properties
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    Container(
                      // Other container properties
                      height: 224,
                      width: 170,
                      child: Card(
                        elevation: 0,
                        color: Colors.white,
                        child: Column(
                          children: [
                            // The first row with the text and the icon
                            const Padding(
                              padding: EdgeInsets.fromLTRB(8,8,8,15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Your Causes",
                                    // Other text properties
                                     style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    // Other icon properties
                                  ),
                                ],
                              ),
                            ),
                            // The second row with two images and titles
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/trees.png",
                                      // Other image properties
                                    ),
                                    Text(
                                      "3 Trees",
                                      style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                                      // Other text properties
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/cups.png",
                                      // Other image properties
                                    ),
                                    Text(
                                      "3 Cups",
                                      // Other text properties
                                       style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // The third row with two images and titles
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/children.png",
                                      // Other image properties
                                    ),
                                    Text(
                                      "3 Children",
                                      // Other text properties
                                       style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/meals.png",
                                      // Other image properties
                                    ),
                                    Text(
                                      "3 Meals",
                                      // Other text properties
                                       style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Tasks(),
                 SizedBox(
                  height: 140,
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
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
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
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: _data,
            isCurved: true,

            shadow: Shadow(
              color: Color.fromARGB(255, 197, 250, 148),
            ),
            //belowBarData: BarAreaData(show: true,color: Color.fromARGB(255, 196, 248, 182)),
            color: Color.fromARGB(255, 0, 244, 57),
            dashArray: [5, 5],
            dotData: FlDotData(
              show: _showDot,
              checkToShowDot: (spot, bardata) {
                // Only show the dot for the last spot in the data
                return spot == _data.last;
              },
            ),
          ),
        ],
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: 0, // Y-coordinate above bottomTitles
              color: Colors.grey,
              strokeWidth: 1,
            ),
          ],
        ),
      ),
    );
  }
}


class Search extends StatelessWidget {
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          // child:
          child: TextField(
            style: TextStyle(fontSize: 14, height: 1),
            cursorColor: Colors.grey,
            controller: _controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: 'Search',
              hintText: 'search',
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(219, 255, 253, 253)),
                borderRadius: BorderRadius.circular(50.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey), // Set the color for the focused border
                borderRadius: BorderRadius.circular(50.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            onChanged: (value) {},
          ),
        ),
       
      ],
    );
  }
}

class Cash extends StatelessWidget {
  const Cash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 177,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
              width: 350,
              child: const Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '\$ 6.1\n',
                            style: TextStyle(
                              color: Color(0xFF00F439),
                              fontSize: 16,
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'saved Yesterday.',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 10,
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Text(
                    'Carbon Balance',
                    style: TextStyle(
                      color: Color(0xFF2E2E2E),
                      fontSize: 16,
                      fontFamily: 'Readex Pro',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 6),
            //Dollar money amount
            Text(
              '\$ 14,489.60',
              style: TextStyle(
                color: Color(0xFF2E2E2E),
                fontSize: 28,
                fontFamily: 'Readex Pro',
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(height: 14),
            //add cash and cashout button
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Add Cash action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00F439),
                      side: BorderSide(width: 1, color: Color(0xFF00F439)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Add Cash',
                      style: TextStyle(
                        color: Color(0xFF2E2E2E),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Cash Out action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E2E2E),
                      side: BorderSide(width: 1, color: Color(0xFF2E2E2E)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Text(
                      'Cash Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0.10,
                      ),
                    ),
                  ),
                ),
              ],
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
    fontSize: 10,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sat', style: style);
      break;

    case 1:
      text = const Text('Sun', style: style);
      break;
    case 2:
      text = const Text('Mon', style: style);
      break;
    case 3:
      text = const Text('Tue', style: style);
      break;
    case 4:
      text = const Text('Wed', style: style);
      break;
    case 5:
      text = const Text('Thu', style: style);
      break;
    case 6:
      text = const Text('Fri', style: style);
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

class Tasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 228.69,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 350,
                  height: 228.69,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 32,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 16,
                child: Text(
                  'Quests from Neu',
                  style: TextStyle(
                    color: Color(0xFF2E2E2E),
                    fontSize: 14,
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                left: 19,
                top: 50,
                child: Container(
                  width: 318,
                  height: 47,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 3,
                        top: 0,
                        child: Container(
                          width: 311,
                          height: 36,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 48,
                                top: 2,
                                child: SizedBox(
                                  width: 169,
                                  child: Text(
                                    'Change your lightbulb into LED.',
                                    style: TextStyle(
                                      color: Color(0xFF2E2E2E),
                                      fontSize: 13,
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFCD7F32),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: SizedBox(
                                  width: 16,
                                  child: Text(
                                    '\$5',
                                    style: TextStyle(
                                      color: Color(0xFF2E2E2E),
                                      fontSize: 13,
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 247,
                                top: 6,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                           child: Image.asset('assets/blackdone.png',),
                                          //decoration: BoxDecoration(color: Color.fromARGB(255, 238, 3, 3)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 287,
                                top: 6,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset('assets/hour.png',),
                                          //decoration: BoxDecoration(color: Color.fromARGB(255, 245, 5, 5)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 115,
                child: Container(
                  width: 318,
                  height: 47,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 3,
                        top: 0,
                        child: Container(
                          width: 311,
                          height: 36,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 48,
                                top: 2,
                                child: SizedBox(
                                  width: 165,
                                  child: Text(
                                    'Set the auto off time between midnight to 4 am.',
                                    style: TextStyle(
                                      color: Color(0xFF2E2E2E),
                                      fontSize: 13,
                                      fontFamily: 'Readex Pro',
                                      fontWeight: FontWeight.w300,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFE8E8E8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFFE8E8E8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(60),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 27.24,
                                        top: 0,
                                        child: Opacity(
                                          opacity: 0.50,
                                          child: Transform(
                                            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.03),
                                            child: Container(
                                              width: 6.08,
                                              height: 43.53,
                                              decoration: BoxDecoration(color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 6,
                                top: 10,
                                child: Text(
                                  '\$10',
                                  style: TextStyle(
                                    color: Color(0xFF2E2E2E),
                                    fontSize: 13,
                                    fontFamily: 'Readex Pro',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 247,
                                top: 6,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset('assets/done.png',),
                                          //decoration: BoxDecoration(color: Color.fromARGB(255, 240, 14, 14)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 287,
                                top: 6,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset('assets/hour.png',),
                                          //decoration: BoxDecoration(color: Color.fromARGB(255, 241, 12, 12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 178,
                child: Container(
                  width: 314,
                  height: 36,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 48,
                        top: 2,
                        child: SizedBox(
                          width: 169,
                          child: Text(
                            'Set the temperature on to 66F.',
                            style: TextStyle(
                              color: Color(0xFF2E2E2E),
                              fontSize: 13,
                              fontFamily: 'Readex Pro',
                              fontWeight: FontWeight.w300,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: ShapeDecoration(
                            color: Color(0xFFF4AF00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 36,
                          height: 36,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFF4AF00),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(60),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 27.24,
                                top: 0,
                                child: Opacity(
                                  opacity: 0.20,
                                  child: Transform(
                                    transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.03),
                                    child: Container(
                                      width: 6.08,
                                      height: 43.53,
                                      decoration: BoxDecoration(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 6,
                        top: 10,
                        child: Text(
                          '\$20',
                          style: TextStyle(
                            color: Color(0xFF2E2E2E),
                            fontSize: 13,
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 250,
                        top: 6,
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset('assets/done.png',),
                                  //decoration: BoxDecoration(color: Color.fromARGB(255, 241, 19, 19)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 290,
                        top: 6,
                        child: Container(
                          width: 24,
                          height: 24,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset('assets/hour.png',),
                                  //decoration: BoxDecoration(color: Color.fromARGB(255, 255, 10, 10)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 273,
                top: 19,
                child: Text(
                  'See All Tasks',
                  style: TextStyle(
                    color: Color(0xFF2E2E2E),
                    fontSize: 10,
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}