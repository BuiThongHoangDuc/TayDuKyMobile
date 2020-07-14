class ScenarioEditModel {
  final String scName,
      scDes,
      scLocation,
      scImage,
      scTimeFrom,
      scTimeTo,
      scScript;
  final int scCastAmout, scId, scStatus;

  ScenarioEditModel(
      {this.scId,
      this.scName,
      this.scImage,
      this.scLocation,
      this.scCastAmout,
      this.scDes,
      this.scTimeFrom,
      this.scTimeTo,
      this.scStatus,
      this.scScript});

  Map<String, dynamic> toJson() => {
        "ScenarioId": scId,
        "ScenarioName": scName,
        "ScenarioDes": scDes,
        "ScenarioLocation": scLocation,
        "ScenarioTimeFrom": scTimeFrom,
        "ScenarioTimeTo": scTimeTo,
        "ScenarioCastAmout": scCastAmout,
        "ScenarioImage": scImage,
        "ScenarioStatus": scStatus,
        "ScenarioScript": scScript,
      };

  factory ScenarioEditModel.fromJson(Map<String, dynamic> json) {
    return ScenarioEditModel(
      scId: json['scenarioId'] as int,
      scName: json['scenarioName'] as String,
      scDes: json['scenarioDes'] as String,
      scLocation: json['scenarioLocation'] as String,
      scTimeFrom: json['scenarioTimeFrom'] as String,
      scTimeTo: json['scenarioTimeTo'] as String,
      scCastAmout: json['scenarioCastAmout'] as int,
      scStatus: json['scenarioStatus'] as int,
      scImage: json['scenarioImage'] as String,
      scScript: json['scenarioScript'] as String,
    );
  }
}
