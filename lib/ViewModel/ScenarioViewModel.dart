import 'package:flutter/material.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioViewModel extends Model {
  final IScenarioRepository _scenario = ScenarioRepository();
  List<ScenarioBasicModel> _scenarioList;

  List<ScenarioBasicModel> get scenarioList => _scenarioList;

  int currentIndex = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  ScenarioViewModel() {
    getAll();
  }

  void getAll() async {
    _isLoading = true;
    notifyListeners();
    _scenarioList = await _scenario.getScenarios().whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
      notifyListeners();
    });
  }

  void onChangeBar(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0)
      getAll();
    else if (selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActorPage(
                    actorVModel: ActorViewModel(),
                  )));
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
