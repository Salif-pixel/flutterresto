import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:flutter_application_1/src/models/modelrestaurant.dart';
import 'package:flutter_application_1/src/repository/Menuplatrepository.dart';
import 'package:flutter_application_1/src/repository/categorieplat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/src/blocs/restaurant_event.dart';
import 'package:flutter_application_1/src/blocs/restaurant_state.dart';
import 'package:flutter_application_1/src/repository/restaurant_repository.dart';

class Restaurantbloc extends Bloc<Restaurant_Event, Restaurant_State> {
  int a = 0;
  RestaurantRepository restaurantRepository = RestaurantRepository();
  CategorieRepository categorieRepository = CategorieRepository();
  Restaurantbloc() : super(RestaurantInitialState()) {
    on<RestaurantEvent>((event, emit) async {
      emit(RestaurantLoadingState());

      try {
        List<Restaurant> restos = await restaurantRepository.ListeRestaurant();

        await Future.delayed(Duration(seconds: 2));

        emit(RestaurantSucessState(listrestos: restos));
      } catch (e) {
        emit(RestaurantErrorState(errormessage: e.toString()));
      }
    });

    on<RestaurantEventSelect>((event, emit) async {
      emit(RestaurantloadingStatedeux());
      try {
        List<Categorie> categorieList = await CategorieRepository()
            .ListeCategorie(event.resto.idRestaurant.toString());
        await Future.delayed(Duration(seconds: 2));
        emit(RestaurantCategorieState(
            Listcategories: categorieList, resto: event.resto));
      } catch (e) {
        emit(RestaurantErrorState(errormessage: e.toString()));
      }
    });
    on<RestaurantinitialEvent>((event, emit) {
      emit(RestaurantInitialState());
    });
    on<RestaurantcategorieselectEvent>((event, emit) async {
      try {
        List<Menu> menus = await MenuRepository().ListeMenu(
            event.resto.idRestaurant.toString(),
            event.categories[event.select].idCateg.toString());
        emit(RestaurantCategorieSelectState(
          select: event.select,
          categories: event.categories,
          resto: event.resto,
          menu: menus,
        ));
      } catch (e) {
        emit(RestaurantErrorState(errormessage: e.toString()));
      }
    });
  }
}
