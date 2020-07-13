class AddActorToScenarioModel {
  final int actorRoleId, actorInScenario, roleScenarioId, scenarioId, admin;
  final String actorRoleDescription, dateUpdate;

  AddActorToScenarioModel({
    this.roleScenarioId,
    this.scenarioId,
    this.actorInScenario,
    this.actorRoleDescription,
    this.actorRoleId,
    this.admin,
    this.dateUpdate,
  });

  Map<String, dynamic> toJson() => {
    "ActorRoleId": actorRoleId,
    "ActorInScenario": actorInScenario,
    "RoleScenarioId": roleScenarioId,
    "ScenarioId": scenarioId,
    "ActorRoleDescription": actorRoleDescription,
    "DateUpdate": dateUpdate,
    "Admin": admin
  };
}
