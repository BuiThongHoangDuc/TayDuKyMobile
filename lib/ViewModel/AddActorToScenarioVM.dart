import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:mobiletayduky/Model/UserBasicModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:scoped_model/scoped_model.dart';

class AddActorToScenarioVM extends Model {
  final IUserRepository _user = UserRepository();
  List<UserBasicModel> _userList;

  List<UserBasicModel> get userList => _userList;

  List<String> _emailUser = [];

  List<String> get emailUser => _emailUser;

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  String _selectedActor;

  String get selectedActor => _selectedActor;

  int _idActor;
  String _nameActor = '';

  String get nameActor => _nameActor;

  final IScenarioRepository _scenario = ScenarioRepository();
  List<ScenarioBasicModel> _scenarioList;

  List<ScenarioBasicModel> get scenarioList => _scenarioList;

  List<String> _scenarioName = [];

  List<String> get scenarioName => _scenarioName;

  int _idScenario;

  String _selectedScenario;

  String get selectedScenario => _selectedScenario;

  bool _isReady = true;

  String _errorScenario = '';

  String get errorScenario => _errorScenario;

  String _errorActor = '';

  String get errorActor => _errorActor;

  Validate _description = Validate(null, null);

  Validate get description => _description;


  void changeSelectedActor(String newValue) {
    _selectedActor = newValue;
    _idActor = _userList[_emailUser.indexOf(newValue)].userId;
    _nameActor = _userList[_emailUser.indexOf(newValue)].userName;
    if (_selectedActor != null) _errorActor = '';
    print(_idActor);
    notifyListeners();
  }

  void changeSelectedScenario(String newValue) {
    _selectedScenario = newValue;
    _idScenario = _scenarioList[_scenarioName.indexOf(newValue)].scID;
    if (_selectedScenario != null) _errorScenario = '';
    print(_idScenario);
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

  AddActorToScenarioVM() {
    getAll();
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
      print(_emailUser);
    }

    _scenarioList = await _scenario.getScenarios().whenComplete(() {
      _scenarioList = scenarioList;
      _isLoading = false;
    });
    if (_scenarioList == null)
      _isNotHave = true;
    else {
      for (int i = 0; i < _scenarioList.length; i++) {
        _scenarioName.add(_scenarioList[i].scName);
      }
    }
    notifyListeners();
  }

  void addActortoScenario() {
    _isReady = true;
    if (_selectedActor == null) {
      _isReady = false;
      _errorActor = "Select Actor Please";
    }
    if (_selectedScenario == null) {
      _isReady = false;
      _errorScenario = "Select Scenario Please";
    }
    if (_description.value == null) {
      changeComment("");
      _isReady = false;
    }

    notifyListeners();
    if (_isReady) {

    }
  }
}
