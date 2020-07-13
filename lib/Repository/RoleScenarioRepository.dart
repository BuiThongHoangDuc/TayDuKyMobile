import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/RoleModel.dart';
import 'package:http/http.dart' as http;

abstract class IRoleScenarioRepository{
  Future<List<RoleModel>> getListEquipment();
}
class RoleScenarioRepository implements IRoleScenarioRepository {
  @override
  Future<List<RoleModel>> getListEquipment() async {
    String urlAPI = APIHelper.apiGetListRole();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(urlAPI, headers: header);
    List<RoleModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => RoleModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;
  }

}