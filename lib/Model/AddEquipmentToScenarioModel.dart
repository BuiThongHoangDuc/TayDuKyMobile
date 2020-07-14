import 'package:scoped_model/scoped_model.dart';

class AddEquipmentToScenarioModel extends Model {
  final int equipInScenario, scenarioId, equipmentId, equipmentQuantity;
  final String createByDate, updateByDate, personUpdate;

  AddEquipmentToScenarioModel(
      {this.equipmentQuantity,
      this.equipmentId,
      this.createByDate,
      this.equipInScenario,
      this.personUpdate,
      this.scenarioId,
      this.updateByDate});

  Map<String, dynamic> toJson() => {
        "EquipInScenario": equipInScenario,
        "ScenarioId": scenarioId,
        "EquipmentId": equipmentId,
        "EquipmentQuantity": equipmentQuantity,
        "CreateByDate": createByDate,
        "UpdateByDate": updateByDate,
        "PersonUpdate": personUpdate,
      };
}
