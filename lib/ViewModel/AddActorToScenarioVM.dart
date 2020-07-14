import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/AddActorToScenarioModel.dart';
import 'package:mobiletayduky/Model/RoleModel.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Model/UserBasicModel.dart';
import 'package:mobiletayduky/Repository/RoleScenarioRepository.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:mobiletayduky/View/ListActorInScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/ListActorInScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddActorToScenarioVM extends Model {
  final IUserRepository _user = UserRepository();
  List<UserBasicModel> _userList;

  AddActorToScenarioModel _addModel;

  List<UserBasicModel> get userList => _userList;

  List<String> _emailUser = [];

  List<String> get emailUser => _emailUser;

  String get selectedActor => _selectedActor;

  int _idActor;
  String _nameActor = '';

  String get nameActor => _nameActor;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  String _selectedActor;

  final IRoleScenarioRepository _roleScenario = RoleScenarioRepository();

  List<RoleModel> _roleList;

  List<RoleModel> get roleList => _roleList;

  List<String> _roleName = [];

  List<String> get roleName => _roleName;

  int _idRole;

  String _selectedRole;

  String get selectedRole => _selectedRole;

  bool _isReady = true;

  String _errorScenario = '';

  String get errorScenario => _errorScenario;

  String _errorActor = '';

  String get errorActor => _errorActor;

  String _errorRole = '';

  String get errorRole => _errorRole;

  Validate _description = Validate(null, null);

  Validate get description => _description;

  int _userId;

  int _scenarioID;

  final IScenarioRepository addRepo = new ScenarioRepository();

  void changeSelectedActor(String newValue) {
    _selectedActor = newValue;
    _idActor = _userList[_emailUser.indexOf(newValue)].userId;
    _nameActor = _userList[_emailUser.indexOf(newValue)].userName;
    if (_selectedActor != null) _errorActor = '';
    print(_idActor);
    notifyListeners();
  }

  void changeSelectedRole(String newValue) {
    _selectedRole = newValue;
    _idRole = _roleList[_roleName.indexOf(newValue)].roleScenarioId;
    if (_selectedRole != null) _errorRole = '';
    print(_idRole);
    notifyListeners();
  }

  void changeComment(String value) {
    if (value.length <= 3 || value.length > 150) {
      _description =
          Validate(null, "Input Must Be > 3 character and < 150 character");
    } else {
      _description = Validate(value, null);
    }
    notifyListeners();
  }

  AddActorToScenarioVM(int scenarioID) {
    getAll();
    this._scenarioID = scenarioID;
  }

  void getAll() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _userList = await _user.getListUser().whenComplete(() {
      _userList = userList;
      _isLoading = false;
    });
    if (_userList == null)
      _isNotHave = true;
    else {
      for (int i = 0; i < userList.length; i++) {
        _emailUser.add(userList[i].userEmail);
      }
    }

    _roleList = await _roleScenario.getListEquipment().whenComplete(() {
      _roleList = roleList;
      _isLoading = false;
    });
    if (_roleList == null)
      _isNotHave = true;
    else {
      for (int i = 0; i < _roleList.length; i++) {
        _roleName.add(_roleList[i].roleScenarioName);
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt("usId");

    notifyListeners();
  }

  void addActortoScenario(BuildContext context) async {
    print(_selectedRole);
    print(_selectedActor);
    _isReady = true;
    if (_selectedActor == null) {
      _isReady = false;
      _errorActor = "Select Actor Please";
    }
    if (_selectedRole == null) {
      _isReady = false;
      _errorRole = "Select Role Please";
    }
    if (_description.value == null) {
      changeComment("");
      _isReady = false;
    }

    notifyListeners();
    if (_isReady) {
      _isLoading = true;
      notifyListeners();

      _addModel = new AddActorToScenarioModel(
          actorInScenario: _idActor,
          actorRoleDescription: _description.value,
          actorRoleId: 0,
          dateUpdate: DateTime.now().toString(),
          roleScenarioId: _idRole,
          scenarioId: _scenarioID,
          admin: _userId);

      String addActorToScenarioJson = jsonEncode(_addModel.toJson());
      print(addActorToScenarioJson);

      String status =
          await addRepo.addActorToScenario(_scenarioID, addActorToScenarioJson);

      if (status == "Ok") {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Add Actor To Scenario Success",
          textColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else if(status == "Conflict"){
        _isReady = false;
        _isLoading = false;
        _errorActor = "Change Another Actor";

        _errorRole = "Change Another Role";
        Fluttertoast.showToast(
          msg: "Add Actor Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      }
      else{
        _isLoading = false;
        Fluttertoast.showToast(
          msg: "Add Actor Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      }
    }
  }
}
