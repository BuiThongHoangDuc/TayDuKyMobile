import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:mobiletayduky/ViewModel/ScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorViewModel extends Model {
  int currentIndex = 1;

  ActorViewModel() {
    print('in here 2');
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
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EquipmentPage(
                    equipVM: EquipmentViewModel(),
                  )));
    }
  }
}
