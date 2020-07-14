import 'package:mobiletayduky/Model/ListEquipmentInScenarioModel.dart';
import 'package:mobiletayduky/Repository/EquipmentInScenarioRepo.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipmentInScenarioListVM extends Model {
  int _scenarioID;
  int get scenarioID => _scenarioID;
  bool _isLoading = false;
  bool _isNotHave = false;

  bool get isLoading => _isLoading;

  bool get isHave => _isNotHave;

  List<ListEquipmentInScenarioModel> _listEquipmentInSc;

  List<ListEquipmentInScenarioModel> get listEquipmentInSc => _listEquipmentInSc;
  final IEquipmentInScenarioRepo _eisRepo = new EquipmentInScenarioRepo();
  EquipmentInScenarioListVM(int scenarioID){
    this._scenarioID = scenarioID;
    getAll();
  }

  void getAll() async {
    _isLoading = true;
    _isNotHave = false;
    notifyListeners();
    _listEquipmentInSc = await _eisRepo.getEquipmentInScenario(_scenarioID).whenComplete(() {
      _listEquipmentInSc = listEquipmentInSc;
      _isLoading = false;
    });
    if (_listEquipmentInSc == null) _isNotHave = true;
    notifyListeners();
  }
}