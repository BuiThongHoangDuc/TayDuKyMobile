import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeViewModel extends Model {
  int currentIndex = 0;

  final PageController pageController = PageController();

  List<Widget> screen = [
    ScenarioPage(),
    ActorPage(),
    EquipmentPage(),
  ];

  void onPageChange(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onChangeBar(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
    notifyListeners();
  }
}
