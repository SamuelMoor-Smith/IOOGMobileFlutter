import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/login/login.dart';

void main() => runApp(const MyApp());

final evaluator = ExpressionEvaluator();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        // primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}