import 'dart:convert';

import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:http/http.dart' as http;

class CategorieRepository {
  Future<List<Categorie>> ListeCategorie(String restoid) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/CategorieMenuApi?param1=$restoid";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Categorie> categorieliste =
            jsonResponse.map((item) => Categorie.fromJson(item)).toList();

        return categorieliste;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
