import 'package:flutter/material.dart';

BottomNavigationBar createBottomNavigationBar(BuildContext context, Widget forward, Widget backwards) {
  void _onItemTapped(int index) {
    if (index == 0) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => backwards,
        ));
    } else {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => forward,
        ));
    }
  }
  return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Back',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Forward',
            backgroundColor: Colors.blue,
          ),
        ],
        onTap: _onItemTapped,
      );
}