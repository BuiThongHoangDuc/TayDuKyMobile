class APIHelper {
  static String apiProject() {
    String url = "192.168.1.10";
    return url;
  }
  static String apiLogin() {
    String url = "http://"+apiProject()+"/api/Login";
    return url;
  }
  static String testAPI() {
    String url = "http://192.168.1.10/api/values";
    return url;
  }
  static String apiListScenario() {
    String url = "http://192.168.1.10/api/Scenarios/List";
    return url;
  }
  static String apiAddScenario() {
    String url = "http://192.168.1.10/api/Scenarios";
    return url;
  }
  static String apiListActor() {
    String url = "http://192.168.1.10/api/Users/List";
    return url;
  }
  static String apiAddUser() {
    String url = "http://192.168.1.10/api/Users";
    return url;
  }
  static String apiListEquipment() {
    String url = "http://192.168.1.10/api/Equipments/List";
    return url;
  }
  static String apiAddEquipment() {
    String url = "http://192.168.1.10/api/Equipments";
    return url;
  }
  static String apiGetListRole() {
    String url = "http://192.168.1.10/api/RoleScenarios";
    return url;
  }
}