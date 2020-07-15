import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Repository/ActorInScenarioRepo.dart';
import 'package:mobiletayduky/View/ActorViewScenarioDonePage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewScenarioDoneVM.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ActorViewScenarioVM extends Model{
  final value = TextEditingController();

  final IActorInScenarioRepo _actorInScenario = ActorInScenarioRepo();
  List<ScenarioBasicModel> _scenarioList;

  List<ScenarioBasicModel> get scenarioList => _scenarioList;

  int currentIndex = 0;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  int _userId;
  int get userID => _userId;

  ActorViewScenarioVM() {
    getAll();
  }

  void getAll() async {
    value.text = "";
    _isLoading = true;
    _isNotHave = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _userId = prefs.getInt("usId");
    notifyListeners();

    _scenarioList = await _actorInScenario.getScenariosNotDone(_userId).whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
    });
    if (_scenarioList == null) _isNotHave = true;
    notifyListeners();
  }

  void launchURL(String urlScenario) async {
    var url = urlScenario;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void onChangeBar(BuildContext context, int selectedIndex) {
    if (selectedIndex == 0)
      getAll();
    else if (selectedIndex == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ActorViewScenarioDonePage(
                avsd: ActorViewScenarioDoneVM(),
              )));
    }
  }


}