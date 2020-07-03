import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Model/AddEquipmentModel.dart';
import 'package:mobiletayduky/Model/EquipmentBasicModel.dart';
import 'package:mobiletayduky/Repository/EquipmentRepository.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/EditEquipmentPage.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/EditEquipmentViewModel.dart';
import 'package:mobiletayduky/ViewModel/ScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipmentViewModel extends Model {
  final value = TextEditingController();
  final IEquipmentRepository _equipment = EquipmentRepository();
  List<EquipmentBasicModel> _equipmentList;

  List<EquipmentBasicModel> get equipmentList => _equipmentList;

  int currentIndex = 2;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  EquipmentViewModel() {
    getAll();
  }

  void getAll() async {
    value.text = "";
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _equipmentList = await _equipment.getListEquipment().whenComplete(() {
      _equipmentList = equipmentList;
      _isLoading = false;
    });
    if (_equipmentList == null) _isNotHave = true;
    notifyListeners();
  }

  void seacrhList(String value) async {
    if (value == '')
      getAll();
    else {
      _isNotHave = false;
      _isLoading = true;
      if (_equipmentList != null) _equipmentList.clear();
      notifyListeners();
      _equipmentList = await _equipment.searchListEquipment(value).whenComplete(() {
        _equipmentList = equipmentList;
        _isLoading = false;
      });
      if (_equipmentList == null) _isNotHave = true;
      notifyListeners();
    }
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
    } else {
      getAll();
    }
  }

  void deleteEquipment(int index) async {
    int deleteID = _equipmentList[index].equipmentId;
    String status = await _equipment.deleteEquipment(deleteID);
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

  void getEquipmentInfo(BuildContext context,int id) async {
    AddEquipmentModel equipment = await _equipment.getEquipmentsByID(id);
    if (equipment == null) {
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
          builder: (context) => EditEqupimentPage(
            editModel: EditEquipmentViewModel(equipment),
          ),
        ),
      );
    }
  }

}
