import 'package:flutter/material.dart';
import 'package:test_2/nav_rall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NavRall(), debugShowCheckedModeBanner: false);
  }
}
