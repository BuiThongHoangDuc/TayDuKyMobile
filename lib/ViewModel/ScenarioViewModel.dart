import 'package:flutter/material.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ScenarioViewModel extends Model {
  final value = TextEditingController();

  final IScenarioRepository _scenario = ScenarioRepository();
  List<ScenarioBasicModel> _scenarioList;

  List<ScenarioBasicModel> get scenarioList => _scenarioList;

  int currentIndex = 0;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  ScenarioViewModel() {
    getAll();
  }

  void getAll() async {
    value.text = "";
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _scenarioList = await _scenario.getScenarios().whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
    });
    if (_scenarioList == null) _isNotHave = true;
    notifyListeners();
  }

  void seacrhList(String value) async {
    if (value == '')
      getAll();
    else {
      _isNotHave = false;
      _isLoading = true;
      if (_scenarioList != null) _scenarioList.clear();
      notifyListeners();
      _scenarioList = await _scenario.searchScenarios(value).whenComplete(() {
        _scenarioList = scenarioList;
        _isLoading = false;
      });
      if (_scenarioList == null) _isNotHave = true;
      notifyListeners();
    }
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
