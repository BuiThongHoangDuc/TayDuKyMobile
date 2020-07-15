class ListEquipmentInScenarioModel {
  final int equipInScenario, equipmentQuantity,status;
  final String equipmentImage,
      scenarioName,
      equipmentName,
      scenarioTimeFrom,
      scenarioTimeTo,
      updateByDate,
      personUpdate;

  ListEquipmentInScenarioModel(
      {this.equipmentName,
      this.equipmentImage,
      this.equipmentQuantity,
      this.equipInScenario,
      this.scenarioName,
      this.scenarioTimeFrom,
      this.scenarioTimeTo,
      this.personUpdate,
      this.updateByDate,
      this.status});

  factory ListEquipmentInScenarioModel.fromJson(Map<String, dynamic> json) {
    return ListEquipmentInScenarioModel(
      equipInScenario: json['equipInScenario'] as int,
      equipmentImage: json['equipmentImage'] as String,
      scenarioName: json['scenarioName'] as String,
      equipmentName: json['equipmentName'] as String,
      equipmentQuantity: json['equipmentQuantity'] as int,
      scenarioTimeFrom: json['scenarioTimeFrom'] as String,
      scenarioTimeTo: json['scenarioTimeTo'] as String,
      updateByDate: json['updateByDate'] as String,
      personUpdate: json['personUpdate'] as String,
      status: json['status'] as int,
    );
  }
}
