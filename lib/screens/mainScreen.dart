// ignore_for_file: file_names

import 'package:egy_news_app/constants/constants.dart';
import 'package:egy_news_app/screens/health.dart';
import 'package:egy_news_app/screens/sports.dart';
import 'package:egy_news_app/screens/technology.dart';
import 'package:flutter/material.dart';

import 'business.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> body = <Widget>[
    const BusinessScreen(),
    const HealthScreen(),
    const SportsScreen(),
    const TechnologyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: PrimaryColor,
          title: const Text(
            'Eg News',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: 'Pacifico',
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.view_headline),
            )
          ],
        ),
        body: body[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.business,
              ),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.health_and_safety),
              label: 'Health',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sports),
              label: 'Sport',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.military_tech),
              label: 'Technology',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: PrimaryColor,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
