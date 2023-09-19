import 'dart:convert';

import 'package:flutter_application_1/src/models/User_model.dart';

import 'package:http/http.dart' as http;

class UserRepository {
  Future<Agent> Login(String login, String password) async {
    String url = "http://10.1.0.40:8080/PadGsr-WEB/api/ConnexionApi";
    var header = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: header,
          body: json.encode({"login": login, "password": password}));
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);

        Agent agent = Agent.fromJson(jsonResponse);

        return agent;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }

  Future<Agent> passwordconfirm(String login, String password, String Npassword,
      String Npassword1) async {
    String url = "http://10.1.0.40:8080/PadGsr-WEB/api/changePasswordApi";
    var header = {'Content-Type': 'application/json'};

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: header,
          body: json.encode({
            "login": login,
            "password": password,
            "newPassword": Npassword,
            "confirmNewPassword": Npassword1
          }));
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);

        Agent agent = Agent.fromJson(jsonResponse);

        return agent;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
