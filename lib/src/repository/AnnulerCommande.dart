import 'dart:convert';

import 'package:flutter_application_1/src/models/HistoriqueCommande_model.dart';

import 'package:http/http.dart' as http;

class HistoriqueRepository {
  Future<String> ListeCommande(String idCommande) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/CommandesApi?idCommande=$idCommande&statut=ANNULE";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);

        String reponse = jsonResponse.toString();

        return reponse;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
