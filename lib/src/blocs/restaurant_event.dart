import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:flutter_application_1/src/models/modelrestaurant.dart';

abstract class Restaurant_Event {}

class RestaurantEventSelect extends Restaurant_Event {
  final Restaurant resto;

  RestaurantEventSelect({required this.resto});
}

class RestaurantEvent extends Restaurant_Event {
  RestaurantEvent();
}

class RestaurantinitialEvent extends Restaurant_Event {
  RestaurantinitialEvent();
}

class RestaurantcategorieselectEvent extends Restaurant_Event {
  final int select;
  final Restaurant resto;
  final List<Categorie> categories;
  RestaurantcategorieselectEvent(
      {required this.select, required this.resto, required this.categories});
}
