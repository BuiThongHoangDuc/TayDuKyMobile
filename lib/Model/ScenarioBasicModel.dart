class ScenarioBasicModel {
  final String scName, scDes, scLocation, scImage,scTimeFrom,scTimeto,scScript;
  final int scID, scStatus;

  ScenarioBasicModel(
      {this.scID,
      this.scName,
      this.scDes,
      this.scLocation,
      this.scImage,
      this.scStatus,this.scTimeFrom,this.scTimeto,this.scScript});

//  Map<String, dynamic> toJson() =>
//      {"userId": userId, "userName": userName, "userEmail": userEmail, "userImage": userImage, "userRole": userRole};

  factory ScenarioBasicModel.fromJson(Map<String, dynamic> json) {
    return ScenarioBasicModel(
      scID: json['scenarioId'] as int,
      scName: json['scenarioName'] as String,
      scDes: json['scenarioDes'] as String,
      scLocation: json['scenarioLocation'] as String,
      scImage: json['scenarioImage'] as String,
      scStatus: json['scenarioStatus'] as int,
      scTimeFrom: json['scenarioTimeFrom'] as String,
      scTimeto: json['scenarioTimeTo'] as String,
      scScript: json['scenarioScript'] as String,
    );
  }
}
