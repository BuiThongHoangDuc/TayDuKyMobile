import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Model/EditActorToScenarioModel.dart';
import 'package:mobiletayduky/Model/ListActorInScenarioModel.dart';
import 'package:mobiletayduky/Repository/ActorInScenarioRepo.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/View/DetailActorInScenarioPage.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DetailActorToScenarioVM.dart';

class ListActorInScenarioVM extends Model {

  final IActorInScenarioRepo _aisRepo = new ActorInScenarioRepo();

  int _scenarioID;
  int get scenarioID => _scenarioID;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  final IScenarioRepository _scenarioRepo = new ScenarioRepository();

  List<ListActorInScenarioModel> _listActorInSc;

  List<ListActorInScenarioModel> get listActorInSc => _listActorInSc;


  ListActorInScenarioVM(int scenarioID){
    this._scenarioID = scenarioID;
    getAll();
    print(_scenarioID);
  }

  void getAll() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _listActorInSc = await _scenarioRepo.getActorInScenario(_scenarioID).whenComplete(() {
      _listActorInSc = listActorInSc;
      _isLoading = false;
    });
    if (_listActorInSc == null) _isNotHave = true;
    notifyListeners();
  }

  void deleteAIS(int index) async {
    int deleteID = _listActorInSc[index].actorRoleId;
    String status = await _aisRepo.deleteAIS(deleteID);
    getAll();
    if (status == "OK") {
      Fluttertoast.showToast(
        msg: "Delete Actor In Scenario Success",
        textColor: Colors.green,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else if (status == "Not Found") {
      Fluttertoast.showToast(
        msg: "Delete Actor In Scenario Fail",
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
    EditActorToScenarioModel ATC = await _aisRepo.getAISByID(id);
    if (ATC == null) {
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
            builder: (context) => DetailActorInScenarioPage(
              editModel: DetailActorToScenarioVM(ATC),
            ),
          ),
        ).then((value) => getAll());
    }
  }

}