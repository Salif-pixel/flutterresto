import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/restaurant_event.dart';
import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:flutter_application_1/src/models/modelrestaurant.dart';

abstract class Restaurant_State {}

class RestaurantInitialState extends Restaurant_State {}

class RestaurantLoadingState extends Restaurant_State {}

class RestaurantSucessState extends Restaurant_State {
  final List<Restaurant> listrestos;
  RestaurantSucessState({required this.listrestos});
}

class RestaurantErrorState extends Restaurant_State {
  String errormessage;
  RestaurantErrorState({required this.errormessage});
}

class RestaurantloadingStatedeux extends Restaurant_State {}

class RestaurantCategorieState extends Restaurant_State {
  final List<Categorie> Listcategories;
  Restaurant resto;
  RestaurantCategorieState({required this.Listcategories, required this.resto});
}

class RestaurantCategorieSelectState extends Restaurant_State {
  final int select;
  final Restaurant resto;
  final List<Categorie> categories;
  final List<Menu> menu;
  RestaurantCategorieSelectState(
      {required this.select,
      required this.categories,
      required this.resto,
      required this.menu});
}
