class ScenarioAddModel {
  final String scName, scDes, scLocation, scImage,scTimeFrom, scTimeTo;
  final int scCastAmout, scId;

  ScenarioAddModel(
      {this.scId,
      this.scName,
      this.scImage,
      this.scLocation,
      this.scCastAmout,
      this.scDes,
      this.scTimeFrom,
      this.scTimeTo});

  Map<String, dynamic> toJson() => {
        "ScenarioId": scId,
        "ScenarioName": scName,
        "ScenarioDes": scDes,
        "ScenarioLocation": scLocation,
        "ScenarioTimeFrom": scTimeFrom,
        "ScenarioTimeTo": scTimeTo,
        "ScenarioCastAmout": scCastAmout,
        "ScenarioImage": scImage
      };
}
