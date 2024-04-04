import 'package:flutter/material.dart';
import 'package:new_money/screens/authenticate/comin_soon.dart';
import 'package:new_money/screens/home/index.dart';
import 'package:new_money/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  static const IconData logout = IconData(0xe3b3, fontFamily: 'MaterialIcons');

  final Function(int) onTap;
  final Color color;
  final int currentIndex;

  CustomBottomNavigationBar(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.currentIndex})
      : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {

  final List icons = [
    'assets/home.png',
    'assets/social_leaderboard.png',
    'assets/monitoring.png',
    'assets/info.png',
    Icons.logout,
  ];

  @override
  Widget build(BuildContext context) {
  
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.center,
       
        children: icons.map((icon) {
    
          int index = icons.indexOf(icon);

         
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              
              icon: isAssetImage(icon)
                  
                  ? Image.asset(
                      icon,
                      color: index == widget.currentIndex
                          ? widget.color
                          : Colors.black,
                      width: 24,
                      height: 24,
                    )
                  : Icon(
                      icon,
                      color: index == widget.currentIndex
                          ? widget.color
                          : Colors.black,
                      size: 24,
                    ),
              onPressed: () => widget.onTap(index),
            ),
          );
        }).toList(),
      ),
    );
  }
}

bool isAssetImage(icon) {
  return icon is String;
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final AuthService _auth = AuthService();

  final List<Widget> _screens = [
    Center(child: Balance()),
    Center(child: ComingSoon()),
    Center(child: ComingSoon()),
    Center(child: ComingSoon()),
    Center(child: ComingSoon()),
  ];

  Color _currentColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
              onTap: (index) async {
                List<int> unclickableIndices = [ ];
                if (unclickableIndices.contains(index)) {
                  return;
                } else if (index == 4) {
                  await _auth.signOut();
                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.clear();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                  return;
                }
                setState(() {
                  _currentIndex = index;
                  _currentColor = Colors.green;
                });
              },
              color: _currentColor,
              currentIndex: _currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}
