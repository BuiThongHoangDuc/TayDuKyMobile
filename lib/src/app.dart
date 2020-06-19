import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoginPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}