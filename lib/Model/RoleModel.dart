class RoleModel {
  final String roleScenarioName;
  final int roleScenarioId;

  RoleModel({
    this.roleScenarioId,
    this.roleScenarioName,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      roleScenarioId: json['roleScenarioId'] as int,
      roleScenarioName: json['roleScenarioName'] as String,
    );
  }
}
