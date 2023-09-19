import 'dart:convert';

import 'package:flutter_application_1/src/models/LigneCommande_model.dart';
import 'package:http/http.dart' as http;

import '../models/lignespecial_model.dart';

class PanierRepository {
  Future<String> Validerpanier(
      List<LigneCommandeSpecial> lignecommandes) async {
    String url = "http://10.1.0.40:8080/PadGsr-WEB/api/LigneCommandeApi";
    var header = {'Content-Type': 'application/json'};
    var a;
    try {
      List<Map<String, dynamic>> lignesJson =
          lignecommandes.map((ligne) => ligne.toJson()).toList();
      a = json.encode(lignesJson);
      http.Response response = await http.post(
        Uri.parse(url),
        headers: header,
        body: a, // Envoyer la liste en tant que JSON
      );
      if (response.statusCode == 200) {
        String reponse = response.body;
        return reponse;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      print(a);
      throw Exception("Error => " + e.toString());
    }
  }
}
