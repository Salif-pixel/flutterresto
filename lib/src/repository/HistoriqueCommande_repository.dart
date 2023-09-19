import 'dart:convert';

import 'package:flutter_application_1/src/models/HistoriqueCommande_model.dart';
import 'package:flutter_application_1/src/models/LigneCommande_model.dart';

import 'package:http/http.dart' as http;

class HistoriqueRepository {
  Future<List<Commande>> ListeCommande(String matricule) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/CommandesApi?matricule=$matricule";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Commande> Commandeliste =
            jsonResponse.map((item) => Commande.fromJson(item)).toList();

        return Commandeliste;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }

  Future<String> AnnulerCommande(String idCommande) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/CommandesApi?idCommande=$idCommande&statut=ANNULE";

    try {
      http.Response response = await http.put(Uri.parse(url));
      if (response.statusCode == 200) {
        String reponse = response.body.toString();

        return reponse;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }

  Future<List<LigneCommande>> DetailCommande(String idCommande) async {
    String url =
        "http://10.1.0.40:8080/PadGsr-WEB/api/LigneCommandeApi?idCommande=$idCommande";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);

        List<LigneCommande> LigneCommandeliste =
            jsonResponse.map((item) => LigneCommande.fromJson(item)).toList();

        return LigneCommandeliste;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
