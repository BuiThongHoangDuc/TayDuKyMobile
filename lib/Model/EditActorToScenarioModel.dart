class EditActorToScenarioModel {
  final int actorRoleId, actorInScenario, roleScenarioId;
  final String actorRoleDescription, dateUpdate,admin;

  EditActorToScenarioModel({
    this.roleScenarioId,
    this.actorInScenario,
    this.actorRoleDescription,
    this.actorRoleId,
    this.admin,
    this.dateUpdate,
  });

  factory EditActorToScenarioModel.fromJson(Map<String, dynamic> json) {
    return EditActorToScenarioModel(
      actorRoleId: json['actorRoleId'] as int,
      actorInScenario: json['actorInScenario'] as int,
      roleScenarioId: json['roleScenarioId'] as int,
      actorRoleDescription: json['actorRoleDescription'] as String,
      dateUpdate: json['dateUpdate'] as String,
      admin: json['admin'] as String,
    );
  }

}