import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/ScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipmentViewModel extends Model {
  int currentIndex = 2;

  EquipmentViewModel() {
    print('in here 3');
  }

  void onChangeBar(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ScenarioPage(
                    scenarioModel: ScenarioViewModel(),
                  )));
    } else if (selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActorPage(
                    actorVModel: ActorViewModel(),
                  )));
    } else {}
  }
}
