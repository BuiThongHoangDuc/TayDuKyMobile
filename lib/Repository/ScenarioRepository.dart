import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:http/http.dart' as http;

abstract class IScenarioRepository {
  Future<List<ScenarioBasicModel>> getScenarios();
}

class ScenarioRepository implements IScenarioRepository {
  @override
  Future<List<ScenarioBasicModel>> getScenarios() async {
    String urlAPI = APIHelper.apiListScenario();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(urlAPI, headers: header);
    List<ScenarioBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ScenarioBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }
}
