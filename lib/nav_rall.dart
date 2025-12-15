import 'package:flutter/material.dart';
import 'package:test_2/color.dart';
import 'package:test_2/dang_nhap.dart';
import 'package:test_2/ds.dart';
import 'package:test_2/form_bt1.dart';
import 'package:test_2/form_bt2.dart';
import 'package:test_2/my_home_page.dart';
import 'package:test_2/my_home_page2.dart';
import 'package:test_2/my_place.dart';
import 'package:test_2/stf_bt1.dart';
import 'package:test_2/stf_bt2.dart';

class NavRall extends StatelessWidget {
  const NavRall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: NavigaBar()));
  }
}

class NavigaBar extends StatefulWidget {
  const NavigaBar({super.key});

  @override
  State<NavigaBar> createState() => _NavigaBarState();
}

class _NavigaBarState extends State<NavigaBar> {
  int _currentIndex = 0;
  bool _extended = false;

  List<Widget> pages = [
    MyApp1(),
    MyPlace(),
    MyHomePage(),
    MyHomePage2(),
    DemSo(),
    BoDemThoiGian(),
    FormBt1(),
    FormBt2(),
    MyApp(),
    DangNhap(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          destinations: [
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 1', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 2', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 3', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 4', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 5', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 6', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 7', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 8', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 9', style: TextStyle(color: Colors.white)),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.book),
              label: Text('Bài 10', style: TextStyle(color: Colors.white)),
            ),
          ],
          selectedIndex: _currentIndex,
          backgroundColor: Colors.black,
          onDestinationSelected: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          leading: IconButton(
            onPressed: () {
              setState(() {
                _extended = !_extended;
              });
            },
            icon: Icon(Icons.menu),
          ),
          extended: _extended,
        ),
        Expanded(child: pages[_currentIndex]),
      ],
    );
  }
}
