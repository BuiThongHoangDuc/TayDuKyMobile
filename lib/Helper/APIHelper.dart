class APIHelper {
  static String apiProject() {
    String url = "192.168.1.11";
    return url;
  }
  static String apiLogin() {
    String url = "http://192.168.1.11/api/Login";
    return url;
  }
  static String testAPI() {
    String url = "http://192.168.1.11/api/values";
    return url;
  }
  static String apiListScenario() {
    String url = "http://192.168.1.11/api/Scenarios/List";
    return url;
  }
  static String apiListActor() {
    String url = "http://192.168.1.11/api/Users/List";
    return url;
  }

  static String apiListEquipment() {
    String url = "http://192.168.1.11/api/Equipments/List";
    return url;
  }
}