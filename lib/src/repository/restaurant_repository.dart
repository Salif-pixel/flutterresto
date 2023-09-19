import 'dart:convert';

import 'package:flutter_application_1/src/models/modelrestaurant.dart';
import 'package:http/http.dart' as http;

class RestaurantRepository {
  Future<List<Restaurant>> ListeRestaurant() async {
    String url = "http://10.1.0.40:8080/PadGsr-WEB/api/RestaurantApi";
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List<dynamic> listRestaurantJson = jsonDecode(response.body);
        List<Restaurant> restaurants = listRestaurantJson
            .map((item) => Restaurant.fromJson(item))
            .toList();
        return restaurants;
      } else {
        throw Exception("Error => ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error => " + e.toString());
    }
  }
}
