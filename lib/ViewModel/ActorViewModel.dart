import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Model/ActorAddModel.dart';
import 'package:mobiletayduky/Model/UserBasicModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:mobiletayduky/View/EditActorPage.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/EditActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:mobiletayduky/ViewModel/ScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorViewModel extends Model {
  final value = TextEditingController();

  final IUserRepository _user = UserRepository();
  List<UserBasicModel> _userList;

  List<UserBasicModel> get userList => _userList;

  int currentIndex = 1;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  ActorViewModel() {
    getAll();
  }

  void getAll() async {
    value.text = "";
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _userList = await _user.getListUser().whenComplete(() {
      _userList = userList;
      _isLoading = false;
    });
    if (_userList == null) _isNotHave = true;
    notifyListeners();
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
      getAll();
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EquipmentPage(
                    equipVM: EquipmentViewModel(),
                  )));
    }
  }

  void seacrhList(String value) async {
    if (value == '')
      getAll();
    else {
      _isNotHave = false;
      _isLoading = true;
      if (_userList != null) _userList.clear();
      notifyListeners();
      _userList = await _user.searchListUser(value).whenComplete(() {
        _userList = userList;
        _isLoading = false;
      });
      if (_userList == null) _isNotHave = true;
      notifyListeners();
    }
  }

  void deleteScenario(int index) async {
    int deleteID = _userList[index].userId;
    String status = await _user.deleteActor(deleteID);
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

  void getActorInfo(BuildContext context,int id) async {
    ActorAddModel actor = await _user.getActorByID(id);
    if (actor == null) {
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
          builder: (context) => EditActorPage(
            editModel: EditActorViewModel(actor),
          ),
        ),
      );
    }
  }

}
