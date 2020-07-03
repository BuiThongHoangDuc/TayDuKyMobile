import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Model/ScenarioAddModel.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Model/ScenarioEditModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/EditScenarioPage.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/EditScenarioViewModel.dart';
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
              builder: (context) =>
                  EquipmentPage(equipVM: EquipmentViewModel())));
    }
  }

  void deleteScenario(int index) async {
    int deleteID = _scenarioList[index].scID;
    String status = await _scenario.deleteScenario(deleteID);
    getAll();
    if (status == "OK") {
      Fluttertoast.showToast(
        msg: "Delete Scenario Success",
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else if (status == "Not Found") {
      Fluttertoast.showToast(
        msg: "Delete Scenario Fail",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Some Thing Wrong With Serve",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  void getDetailInfo(BuildContext context,int id) async {
    ScenarioEditModel scenario = await _scenario.getScenariosByID(id);
    if (scenario == null) {
      Fluttertoast.showToast(
        msg: "Is No Longer Available",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScenarioPage(
            editModel: EditScenarioViewModel(scenario),
          ),
        ),
      );
    }
  }
}
