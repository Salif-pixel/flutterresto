import 'dart:convert';

import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:http/http.dart' as http;

class MenuRepository {
  Future<List<Menu>> ListeMenu(String restoid, String idcateg) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/MenuApi?param1=$restoid&param2=$idcateg";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Menu> Menuliste =
            jsonResponse.map((item) => Menu.fromJson(item)).toList();

        return Menuliste;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
