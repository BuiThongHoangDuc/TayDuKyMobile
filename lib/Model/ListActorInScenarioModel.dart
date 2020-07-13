class ListActorInScenarioModel {
  final int actorRoleId;
  final String actorInScenario, roleScenarioId, dateUpdate, admin, actorEmail;

  ListActorInScenarioModel(
      {this.actorRoleId,
      this.dateUpdate,
      this.admin,
      this.actorInScenario,
      this.roleScenarioId,
      this.actorEmail});

  factory ListActorInScenarioModel.fromJson(Map<String, dynamic> json) {
    return ListActorInScenarioModel(
      actorRoleId: json['actorRoleId'] as int,
      actorInScenario: json['actorInScenario'] as String,
      roleScenarioId: json['roleScenarioId'] as String,
      dateUpdate: json['dateUpdate'] as String,
      admin: json['admin'] as String,
      actorEmail: json['actorEmail'] as String,
    );
  }
}
