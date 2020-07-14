import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/AddEquipmentToScenarioModel.dart';
import 'package:mobiletayduky/Model/EquipmentBasicModel.dart';
import 'package:mobiletayduky/Repository/EquipmentInScenarioRepo.dart';
import 'package:mobiletayduky/Repository/EquipmentRepository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEquipmentInScenarioVM extends Model{

  AddEquipmentToScenarioModel _addModel;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  final IEquipmentRepository _equipmentRepo = EquipmentRepository();

  List<EquipmentBasicModel> _equipmentList;

  List<EquipmentBasicModel> get equipmentList => _equipmentList;

  List<String> _equipmentName = [];

  List<String> get equipmentName => _equipmentName;

  int _idEquipment;

  String _selectedEquipment;

  String get selectedEquipment => _selectedEquipment;

  bool _isReady = true;

  String _errorEquipment = '';

  String get errorEquipment => _errorEquipment;

  Validate _quantity = Validate(null, null);
  Validate get quantity => _quantity;

  int _scenarioID;

  String _userName;

  final IEquipmentInScenarioRepo _eis = new EquipmentInScenarioRepo();

  //Setters
  void changeQuantity(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _quantity = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) > 999) {
      _quantity = Validate(null, "Input Must < 999");
    } else {
      _quantity = Validate(value, null);
    }
    notifyListeners();
  }

  void getAll() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _equipmentList = await _equipmentRepo.getListEquipment().whenComplete(() {
      _equipmentList = equipmentList;
      _isLoading = false;
    });
    if (_equipmentList == null)
      _isNotHave = true;
    else {
      for (int i = 0; i < _equipmentList.length; i++) {
        _equipmentName.add(_equipmentList[i].equipmentName);
      }
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString("usName");

    notifyListeners();
  }

  AddEquipmentInScenarioVM(int scenarioID) {
    getAll();
    this._scenarioID = scenarioID;
  }

  void changeSelectedEquipment(String newValue) {
    _selectedEquipment = newValue;
    _idEquipment = _equipmentList[_equipmentName.indexOf(newValue)].equipmentId;
    if (_selectedEquipment != null) _errorEquipment = '';
    print(_idEquipment);
    notifyListeners();
  }

  void addEquipmentScenario(BuildContext context) async {
    print(_idEquipment);
    print(_scenarioID);
    _isReady = true;
    if (_selectedEquipment == null) {
      _isReady = false;
      _errorEquipment = "Select Actor Please";
    }
    if (_quantity.value == null) {
      changeQuantity("");
      _isReady = false;
    }

    notifyListeners();
    if (_isReady) {
      _isLoading = true;
      notifyListeners();

      _addModel = new AddEquipmentToScenarioModel(
          scenarioId: _scenarioID,
      createByDate: DateTime.now().toString(),
        equipInScenario: 0,
        equipmentId: _idEquipment,
        equipmentQuantity: int.parse(_quantity.value),
        personUpdate: _userName,
        updateByDate: DateTime.now().toString()
      );

      String addActorToScenarioJson = jsonEncode(_addModel.toJson());
      print(addActorToScenarioJson);

      String status =
      await _eis.addEquipmentToScenario(_scenarioID, addActorToScenarioJson);

      if (status == "Ok") {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Add Equipment To Scenario Success",
          textColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else if(status == "Conflict"){
        _isReady = false;
        _isLoading = false;
        _quantity = Validate(null, "Quantity Avaliable < Than Your Input");
        Fluttertoast.showToast(
          msg: "Add Equipment Fail",
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
          msg: "Add Equipment Fail",
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