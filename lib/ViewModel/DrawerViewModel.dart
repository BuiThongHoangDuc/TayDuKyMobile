import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoginPage.dart';
import 'package:mobiletayduky/ViewModel/LoginViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerViewModel extends Model {
  String userName, userEmail, userImage;

  DrawerViewModel() {
    getSimpleInfo();
  }

  void getSimpleInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("usName");
    userEmail = prefs.getString("usEmail");
    userImage = prefs.getString("usImage");
    notifyListeners();
  }

  void signOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(LoginViewModel())),
    );
  }
}
