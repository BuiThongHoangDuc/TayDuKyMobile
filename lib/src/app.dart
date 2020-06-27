import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoginPage.dart';
import 'package:mobiletayduky/ViewModel/LoginViewModel.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      home: LoginPage(LoginViewModel())
    );
  }
}