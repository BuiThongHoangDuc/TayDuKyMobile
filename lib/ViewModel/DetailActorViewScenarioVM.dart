import 'package:mobiletayduky/Model/ListActorInScenarioModel.dart';
import 'package:mobiletayduky/Model/ScenarioEditModel.dart';
import 'package:mobiletayduky/Repository/ActorInScenarioRepo.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailActorViewScenarioVM extends Model{
  int _scenarioID;
  int _actorID;

  final IActorInScenarioRepo _aisRepo = new ActorInScenarioRepo();

  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  List<ListActorInScenarioModel> _listActorInSc;

  List<ListActorInScenarioModel> get listActorInSc => _listActorInSc;

  DetailActorViewScenarioVM(int scenarioID, int actorID)
  {
    _scenarioID = scenarioID;
    _actorID = actorID;
    getAll();
  }

  void getAll() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _listActorInSc = await _aisRepo.getRoleInScenario(_actorID, _scenarioID).whenComplete(() {
      _listActorInSc = listActorInSc;
      _isLoading = false;
    });
    if (_listActorInSc == null) _isNotHave = true;
    notifyListeners();
  }

}