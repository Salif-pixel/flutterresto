import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_application_1/src/blocs/UserAuthbloc.dart';
import 'package:flutter_application_1/src/blocs/panier_event.dart';
import 'package:flutter_application_1/src/blocs/panier_state.dart';
import 'package:flutter_application_1/src/blocs/panierbloc.dart';
import 'package:flutter_application_1/src/blocs/restaurant_event.dart';
import 'package:flutter_application_1/src/blocs/restaurant_state.dart';
import 'package:flutter_application_1/src/blocs/restaurantbloc.dart';
import 'package:flutter_application_1/src/blocs/user_Auth_state.dart';
import 'package:flutter_application_1/src/models/LigneCommande_model.dart';
import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/categorieplat_model.dart';
import 'package:flutter_application_1/src/models/lignespecial_model.dart';

import 'package:flutter_application_1/src/models/modelrestaurant.dart';
import 'package:flutter_application_1/src/ui/app.dart';
import 'package:flutter_application_1/src/ui/app3.dart';
import 'package:flutter_application_1/src/ui/app4.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../models/User_model.dart';

class MyPage2 extends StatelessWidget {
  String matricule = "";
  Agent agents = Agent();
  int solde = 0;
  int prixtotal = 0;
  bool notif = false;
  final _advancedDrawerController = AdvancedDrawerController();

  MyPage2({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<Restaurantbloc>(context).add(RestaurantEvent());
    Future<void> handleRefresh() async {
      _refreshpage(context, MyPage2());
      return await Future.delayed(const Duration(seconds: 1));
    }

    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 15, 21, 65),
              Color.fromARGB(255, 48, 55, 111),
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: AppDrawer(context),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          shape:
              ContinuousRectangleBorder(borderRadius: BorderRadius.circular(4)),
          toolbarHeight: 80,
          backgroundColor: const Color.fromARGB(255, 15, 21, 65),
          title: AppbarMenu(
            context,
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: LiquidPullToRefresh(
          onRefresh: handleRefresh,
          color: const Color.fromARGB(255, 15, 21, 65),
          backgroundColor: Color.fromARGB(255, 33, 192, 255),
          height: 100,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: BlocListener<Panierbloc, Panier_State>(
              listener: (context, state) {
                if (state is PanierSucessState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Ajout réussi',
                    text: "Votre ajout s'est bien effectuée",
                  );
                } else if (state is PanierErreurState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    title: 'Oops',
                    text: state.message,
                  );
                } else if (state is PanierValideState) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    title: 'Achat réussi',
                    text: "Votre achat s'est bien effectuée",
                  );
                }
              },
              child: BlocBuilder<Restaurantbloc, Restaurant_State>(
                  builder: (context, state) {
                if (state is RestaurantLoadingState) {
                  return Loading(context);
                } else if (state is RestaurantSucessState) {
                  return Listrestaurantwidget(context, state.listrestos);
                } else if (state is RestaurantErrorState) {
                  _Errorexception(context, state.errormessage);
                } else if (state is RestaurantloadingStatedeux) {
                  return Loading2(context);
                } else if (state is RestaurantCategorieState) {
                  return buildinitialcategorie(
                      context, state.Listcategories, state.resto);
                } else if (state is RestaurantCategorieSelectState) {
                  return buildselectgreencategorie(context, state.select,
                      state.categories, state.resto, state.menu);
                }
                return Container();
              }),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET

  // ignore: non_constant_identifier_names

  @override
  Widget buildinitialcategorie(
          context, List<Categorie> categorieliste, resto) =>
      Container(
        width: double.infinity,
        height: 800,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                child: Image.asset(
                  resto.idRestaurant == "RESTO_1"
                      ? "lib/assets/resto0.png"
                      : resto.idRestaurant == "RESTO_2"
                          ? "lib/assets/resto1.png"
                          : resto.idRestaurant == "RESTO_3"
                              ? "lib/assets/resto2.png"
                              : resto.idRestaurant == "RESTO_4"
                                  ? "lib/assets/resto3.png"
                                  : resto.idRestaurant == "RESTO_5"
                                      ? "lib/assets/resto4.png"
                                      : "lib/assets/resto5.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      scrollDirection: Axis.horizontal,
                      children: buildgridListcategorie(categorieliste.length,
                          context, -1, categorieliste, resto),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  @override
  Widget buildselectgreencategorie(context, int select,
          List<Categorie> listecategorie, resto, List<Menu> menus) =>
      Container(
        width: double.infinity,
        height: 700,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                child: Image.asset(
                  resto.idRestaurant == "RESTO_1"
                      ? "lib/assets/resto0.png"
                      : resto.idRestaurant == "RESTO_2"
                          ? "lib/assets/resto1.png"
                          : resto.idRestaurant == "RESTO_3"
                              ? "lib/assets/resto2.png"
                              : resto.idRestaurant == "RESTO_4"
                                  ? "lib/assets/resto3.png"
                                  : resto.idRestaurant == "RESTO_5"
                                      ? "lib/assets/resto4.png"
                                      : "lib/assets/resto5.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      scrollDirection: Axis.horizontal,
                      children: buildgridListcategorie(listecategorie.length,
                          context, select, listecategorie, resto),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 470,
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) => Card(
                    color: listecategorie[select].code == "P_SEN"
                        ? Colors.amberAccent
                        : listecategorie[select].code == "DESRT"
                            ? Colors.pinkAccent
                            : listecategorie[select].code == "VIENN"
                                ? const Color.fromARGB(255, 221, 160, 138)
                                : listecategorie[select].code == "B_FRAI"
                                    ? Colors.blueAccent
                                    : listecategorie[select].code == "P_EUR"
                                        ? Color.fromARGB(255, 0, 58, 105)
                                        : listecategorie[select].code == "NR"
                                            ? Color.fromARGB(255, 0, 117, 61)
                                            : listecategorie[select].code ==
                                                    "B_CHAU"
                                                ? Colors.brown
                                                : listecategorie[select].code ==
                                                        "P_AFR"
                                                    ? Colors.orangeAccent
                                                    : listecategorie[select]
                                                                .code ==
                                                            "P_DEJ"
                                                        ? Color.fromARGB(
                                                            255, 0, 238, 255)
                                                        : Colors.grey,
                    child: ListTile(
                      leading: Icon(
                        listecategorie[select].code == "P_SEN"
                            ? Icons.rice_bowl
                            : listecategorie[select].code == "DESRT"
                                ? Icons.icecream
                                : listecategorie[select].code == "VIENN"
                                    ? Icons.breakfast_dining
                                    : listecategorie[select].code == "B_FRAI"
                                        ? Icons.water
                                        : listecategorie[select].code == "P_EUR"
                                            ? Icons.local_pizza
                                            : listecategorie[select].code ==
                                                    "NR"
                                                ? Icons.food_bank
                                                : listecategorie[select].code ==
                                                        "B_CHAU"
                                                    ? Icons.free_breakfast
                                                    : listecategorie[select]
                                                                .code ==
                                                            "P_AFR"
                                                        ? Icons.restaurant_menu
                                                        : listecategorie[select]
                                                                    .code ==
                                                                "P_DEJ"
                                                            ? Icons
                                                                .breakfast_dining
                                                            : Icons.restaurant,
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        menus[index].libellePlat.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14),
                      ),
                      subtitle: Text(
                        "${menus[index].prixAvecSubvention.toString()} F",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      trailing: GestureDetector(
                        child: Icon(Icons.add),
                        onTap: () {
                          LigneCommande ligneCommande = LigneCommande();
                          ligneCommande.libelleProduit =
                              menus[index].libellePlat;
                          ligneCommande.idRestaurant =
                              menus[index].categorie?.resto?.idRestaurant;
                          ligneCommande.idProduit = menus[index].idPlat;
                          ligneCommande.matricule = matricule;
                          ligneCommande.prixAvecSubvention =
                              menus[index].prixAvecSubvention;
                          ligneCommande.quantite = 1;
                          ligneCommande.code = menus[index].categorie?.code;

                          BlocProvider.of<Panierbloc>(context).add(
                              PanierAjoutEvent(ligneCommande: ligneCommande));
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  @override
  List<Container> buildgridListcategorie(int count, context, int select,
          List<Categorie> categorieliste, resto) =>
      List.generate(
        count,
        (i) => Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ]),
          child: Column(
            children: [
              Container(
                height: 100,
                child: GridTile(
                  child: Container(
                    color: categorieliste[i].code == "P_SEN"
                        ? Colors.amberAccent
                        : categorieliste[i].code == "DESRT"
                            ? Colors.pinkAccent
                            : categorieliste[i].code == "VIENN"
                                ? const Color.fromARGB(255, 221, 160, 138)
                                : categorieliste[i].code == "B_FRAI"
                                    ? Colors.blueAccent
                                    : categorieliste[i].code == "P_EUR"
                                        ? Color.fromARGB(255, 0, 58, 105)
                                        : categorieliste[i].code == "NR"
                                            ? Color.fromARGB(255, 0, 117, 61)
                                            : categorieliste[i].code == "B_CHAU"
                                                ? Colors.brown
                                                : categorieliste[i].code ==
                                                        "P_AFR"
                                                    ? Colors.orangeAccent
                                                    : categorieliste[i].code ==
                                                            "P_DEJ"
                                                        ? Color.fromARGB(
                                                            255, 0, 238, 255)
                                                        : Colors.grey,
                    child: Icon(
                      categorieliste[i].code == "P_SEN"
                          ? Icons.rice_bowl
                          : categorieliste[i].code == "DESRT"
                              ? Icons.icecream
                              : categorieliste[i].code == "VIENN"
                                  ? Icons.breakfast_dining
                                  : categorieliste[i].code == "B_FRAI"
                                      ? Icons.water
                                      : categorieliste[i].code == "P_EUR"
                                          ? Icons.local_pizza
                                          : categorieliste[i].code == "NR"
                                              ? Icons.food_bank
                                              : categorieliste[i].code ==
                                                      "B_CHAU"
                                                  ? Icons.free_breakfast
                                                  : categorieliste[i].code ==
                                                          "P_AFR"
                                                      ? Icons.restaurant_menu
                                                      : categorieliste[i]
                                                                  .code ==
                                                              "P_DEJ"
                                                          ? Icons
                                                              .breakfast_dining
                                                          : Icons.restaurant,
                      size: 30,
                      color: Color.fromARGB(247, 255, 255, 255),
                    ),
                  ),
                  footer: GestureDetector(
                    child: Container(
                      height: 20,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                categorieliste[i].libelleCateg.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      BlocProvider.of<Restaurantbloc>(context).add(
                          RestaurantcategorieselectEvent(
                              select: i,
                              resto: resto,
                              categories: categorieliste));
                    },
                  ),
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.circle,
                  size: 15,
                  color: select == i
                      ? Colors.green
                      : Color.fromARGB(255, 15, 21, 65),
                ),
              ),
            ],
          ),
        ),
      );
  Widget AppbarMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
            ),
            Title(
              color: Colors.white,
              child: BlocBuilder<UserAuthbloc, User_Auth_State>(
                builder: (context, state) {
                  matricule = state.agent.matricule.toString();
                  agents = state.agent;
                  return Text(
                    "${state.agent.prenom.toString()} ${state.agent.nom.toString()}",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.attach_money,
                color: Color.fromARGB(255, 19, 228, 0),
                size: 40,
              ),
            ),
            Title(
              color: Colors.white,
              child: BlocBuilder<UserAuthbloc, User_Auth_State>(
                builder: (context, state) {
                  solde = state.agent.solde!;
                  return Text(
                    state.agent.solde.toString(),
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  );
                },
              ),
            ),
          ],
        ),
        GestureDetector(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<Panierbloc>(context)
                          .add(PanierEtatEvent());
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Panier"),
                            content: Container(
                              height: 300,
                              width: 500,
                              child: BlocBuilder<Panierbloc, Panier_State>(
                                  builder: (context, state) {
                                TextEditingController controllerquantite =
                                    TextEditingController();
                                String quantite = "1";
                                if (state is PanierInitialState) {
                                } else if (state is PanierEtatState) {
                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 240,
                                          child: ListView.builder(
                                            itemCount:
                                                state.ligneCommandes.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Slidable(
                                                  endActionPane: ActionPane(
                                                    motion: ScrollMotion(),
                                                    children: [
                                                      // A SlidableAction can have an icon and/or a label.
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return Container(
                                                                height: 100,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            40),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            40),
                                                                  ),
                                                                ),
                                                                child: Center(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      GestureDetector(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          color:
                                                                              Colors.red,
                                                                          padding: EdgeInsets.symmetric(
                                                                              horizontal: 158.9,
                                                                              vertical: 15),
                                                                          child:
                                                                              Text(
                                                                            'supprimer',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 20),
                                                                          ),
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          BlocProvider.of<Panierbloc>(context)
                                                                              .add(PanierSupprimerEvent(ligneCommande: state.ligneCommandes[index]));

                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            GestureDetector(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                Colors.blueAccent,
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                'annuler',
                                                                                style: TextStyle(color: Colors.white, fontSize: 22),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        backgroundColor:
                                                            Color(0xFFFE4A49),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        label: 'Supprimer',
                                                      ),
                                                    ],
                                                  ),
                                                  startActionPane: ActionPane(
                                                    motion: ScrollMotion(),
                                                    children: [
                                                      // A SlidableAction can have an icon and/or a label.
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          showModalBottomSheet(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return SizedBox(
                                                                height: 200,
                                                                child: Center(
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            45,
                                                                            132,
                                                                            255),
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                143.9,
                                                                            vertical:
                                                                                20),
                                                                        child:
                                                                            Text(
                                                                          'ajouter quantite',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 17),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                20,
                                                                            horizontal:
                                                                                20),
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 16),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                              color: Colors.grey.withOpacity(0.5), // Couleur et opacité de l'ombre
                                                                              spreadRadius: 2, // Étalement de l'ombre
                                                                              blurRadius: 5, // Flou de l'ombre
                                                                              offset: Offset(0, 3), // Décalage de l'ombre (x, y)
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        child:
                                                                            TextFormField(
                                                                          keyboardType:
                                                                              TextInputType.number,
                                                                          controller:
                                                                              controllerquantite,
                                                                          decoration: InputDecoration(
                                                                              hintText: 'quantité',
                                                                              border: InputBorder.none,
                                                                              icon: Icon(
                                                                                Icons.production_quantity_limits,
                                                                                color: Color.fromARGB(255, 15, 21, 65),
                                                                                size: 50,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            ElevatedButton(
                                                                                onPressed: () {
                                                                                  LigneCommande ligneCommande1 = state.ligneCommandes[index];
                                                                                  quantite = controllerquantite.text.toString();
                                                                                  ligneCommande1.quantite = int.tryParse(quantite);
                                                                                  BlocProvider.of<Panierbloc>(context).add(PanierUpdateEvent(ligneCommande: ligneCommande1));
                                                                                  Navigator.pop(context);
                                                                                  print(quantite);
                                                                                },
                                                                                child: Text('valider')),
                                                                            ElevatedButton(
                                                                                onPressed: () {
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Text('annuler')),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        backgroundColor:
                                                            Color.fromARGB(
                                                                255, 0, 23, 56),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.add,
                                                        label: 'ajouter',
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              1),
                                                      color: state
                                                                  .ligneCommandes[
                                                                      index]
                                                                  .code ==
                                                              "P_SEN"
                                                          ? Colors.amberAccent
                                                          : state
                                                                      .ligneCommandes[
                                                                          index]
                                                                      .code ==
                                                                  "DESRT"
                                                              ? Colors
                                                                  .pinkAccent
                                                              : state.ligneCommandes[index].code ==
                                                                      "VIENN"
                                                                  ? const Color.fromARGB(
                                                                      255,
                                                                      221,
                                                                      160,
                                                                      138)
                                                                  : state.ligneCommandes[index].code ==
                                                                          "B_FRAI"
                                                                      ? Colors
                                                                          .blueAccent
                                                                      : state.ligneCommandes[index].code ==
                                                                              "P_EUR"
                                                                          ? Color.fromARGB(
                                                                              255,
                                                                              0,
                                                                              58,
                                                                              105)
                                                                          : state.ligneCommandes[index].code == "NR"
                                                                              ? Color.fromARGB(255, 0, 117, 61)
                                                                              : state.ligneCommandes[index].code == "B_CHAU"
                                                                                  ? Colors.brown
                                                                                  : state.ligneCommandes[index].code == "P_AFR"
                                                                                      ? Colors.orangeAccent
                                                                                      : state.ligneCommandes[index].code == "P_DEJ"
                                                                                          ? Color.fromARGB(255, 0, 238, 255)
                                                                                          : Colors.grey,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          child: ListTile(
                                                            leading: Icon(
                                                              state
                                                                          .ligneCommandes[
                                                                              index]
                                                                          .code ==
                                                                      "P_SEN"
                                                                  ? Icons
                                                                      .rice_bowl
                                                                  : state.ligneCommandes[index].code ==
                                                                          "DESRT"
                                                                      ? Icons
                                                                          .icecream
                                                                      : state.ligneCommandes[index].code ==
                                                                              "VIENN"
                                                                          ? Icons
                                                                              .breakfast_dining
                                                                          : state.ligneCommandes[index].code == "B_FRAI"
                                                                              ? Icons.water
                                                                              : state.ligneCommandes[index].code == "P_EUR"
                                                                                  ? Icons.local_pizza
                                                                                  : state.ligneCommandes[index].code == "NR"
                                                                                      ? Icons.food_bank
                                                                                      : state.ligneCommandes[index].code == "B_CHAU"
                                                                                          ? Icons.free_breakfast
                                                                                          : state.ligneCommandes[index].code == "P_AFR"
                                                                                              ? Icons.restaurant_menu
                                                                                              : state.ligneCommandes[index].code == "P_DEJ"
                                                                                                  ? Icons.breakfast_dining
                                                                                                  : Icons.restaurant,
                                                              size: 30,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                            ),
                                                            title: Text(
                                                              state
                                                                  .ligneCommandes[
                                                                      index]
                                                                  .libelleProduit
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 14),
                                                            ),
                                                            subtitle: Text(
                                                              "${state.ligneCommandes[index].prixAvecSubvention} F",
                                                              style: TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Text(
                                                            state
                                                                .ligneCommandes[
                                                                    index]
                                                                .quantite
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          width: 150,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.amber,
                                          ),
                                          child: Center(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.done,
                                                    size: 30,
                                                    color: Color.fromARGB(
                                                        255, 10, 2, 99),
                                                  ),
                                                  onPressed: () {
                                                    prixtotal = 0;
                                                    for (int o = 0;
                                                        o <
                                                            state.ligneCommandes
                                                                .length;
                                                        o++) {
                                                      prixtotal = prixtotal +
                                                          state
                                                                  .ligneCommandes[
                                                                      o]
                                                                  .prixAvecSubvention! *
                                                              state
                                                                  .ligneCommandes[
                                                                      o]
                                                                  .quantite!;
                                                    }

                                                    if (state.ligneCommandes
                                                            .isNotEmpty &&
                                                        solde > prixtotal) {
                                                      List<LigneCommandeSpecial>
                                                          commandestemps = [];
                                                      for (int i = 0;
                                                          i <
                                                              state
                                                                  .ligneCommandes
                                                                  .length;
                                                          i++) {
                                                        LigneCommandeSpecial
                                                            temp =
                                                            LigneCommandeSpecial();
                                                        temp.libelleProduit =
                                                            state
                                                                .ligneCommandes[
                                                                    i]
                                                                .libelleProduit;
                                                        temp.idRestaurant =
                                                            state
                                                                .ligneCommandes[
                                                                    i]
                                                                .idRestaurant;
                                                        temp.idProduit = state
                                                            .ligneCommandes[i]
                                                            .idProduit;
                                                        temp.matricule =
                                                            matricule;
                                                        temp.prixAvecSubvention =
                                                            state
                                                                .ligneCommandes[
                                                                    i]
                                                                .prixAvecSubvention;
                                                        temp.quantite = state
                                                            .ligneCommandes[i]
                                                            .quantite
                                                            .toString();
                                                        commandestemps
                                                            .add(temp);
                                                      }
                                                      state.ligneCommandes
                                                          .clear();

                                                      BlocProvider.of<
                                                                  Panierbloc>(
                                                              context)
                                                          .add(PanierValideEvent(
                                                              Listeligne: state
                                                                  .ligneCommandes,
                                                              ListeligneCommande:
                                                                  commandestemps,
                                                              matricule:
                                                                  matricule));
                                                    } else {
                                                      _Errorexception(context,
                                                          "Votre solde est insuffisant");
                                                    }
                                                  })),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              }),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Fermer le dialogue
                                },
                                child: Text("Fermer"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    // [{"idRestaurant":"RESTO_5","idProduit":"MENU_RESTO_5_36","matricule":"607863","libelleProduit":"Demi Mouton","prixAvecSubvention":17500,"quantite":"1"}]
                    icon: const Icon(
                      Icons.shopping_basket_sharp,
                      color: Color.fromARGB(255, 17, 219, 255),
                      size: 40,
                    ),
                  ),
                  Positioned(
                    left: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BlocBuilder<Panierbloc, Panier_State>(
                          builder: (context, state) {
                        if (state.ligneCommandes.length > 0) {
                          notif = true;
                        } else if (state.ligneCommandes.length == 0) {
                          notif = false;
                        }

                        return Container(
                          height: 20,
                          width: 20,
                          color:
                              notif == true ? Colors.red : Colors.transparent,
                          child: Center(
                            child: Text(
                              state.ligneCommandes.length.toString(),
                              style: TextStyle(
                                fontSize: 15,
                                color: notif == true
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              Title(
                color: Colors.white,
                child: const Text(
                  'panier',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleMenuButtonPressed() {
    // NOTICE: Manage Advanced Drawer state through the Controller.
    // _advancedDrawerController.value = AdvancedDrawerValue.visible();
    _advancedDrawerController.showDrawer();
  }
}

void _Errorexception(BuildContext context, String message) {
  Future.delayed(Duration.zero, () {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
    );
    // Autres opérations à effectuer après l'affichage de QuickAlert
  });
}

@override
Widget Bottomnav() => Container(
      color: Color.fromARGB(255, 15, 21, 65),
      child: GNav(
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromARGB(255, 92, 140, 236),
          tabMargin: EdgeInsets.all(7),
          tabs: [
            GButton(
              icon: Icons.food_bank_outlined,
              text: 'restaurant',
              onPressed: () {},
            ),
            GButton(
              icon: Icons.today,
              text: 'Menu du jour',
              onPressed: () {},
            ),
            GButton(
              icon: Icons.note_add,
              text: 'historique',
              onPressed: () {},
            ),
          ]),
    );

@override
Widget Listrestaurantwidget(context, List<Restaurant> listrestos) => Container(
      width: double.infinity,
      height: 800,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: GridView.count(
        crossAxisCount: 1,
        scrollDirection: Axis.horizontal,
        children: buildgridList(listrestos.length, listrestos, context),
      ),
    );

@override
List<Container> buildgridList(int count, List<Restaurant> restos, context) =>
    List.generate(
      count,
      (i) => Container(
        margin: EdgeInsets.only(left: 29, top: 40, bottom: 150),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
        child: GridTile(
          child: Image.asset(
            restos[i].idRestaurant == "RESTO_1"
                ? "lib/assets/resto0.png"
                : restos[i].idRestaurant == "RESTO_2"
                    ? "lib/assets/resto1.png"
                    : restos[i].idRestaurant == "RESTO_3"
                        ? "lib/assets/resto2.png"
                        : restos[i].idRestaurant == "RESTO_4"
                            ? "lib/assets/resto3.png"
                            : restos[i].idRestaurant == "RESTO_5"
                                ? "lib/assets/resto4.png"
                                : "lib/assets/resto5.png",
            fit: BoxFit.cover,
          ),
          footer: GestureDetector(
            child: Container(
              height: 80,
              color: Colors.black.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restaurant:',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    "${restos[i].nom.toString()}",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            onTap: () {
              BlocProvider.of<Restaurantbloc>(context)
                  .add(RestaurantEventSelect(resto: restos[i]));
            },
          ),
        ),
      ),
    );
@override
Widget Loading2(context) => Container(
      width: double.infinity,
      height: 800,
      color: Color.fromARGB(255, 164, 241, 255),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: TextLiquidFill(
                text: 'patientez un instant ',
                waveColor: Color.fromARGB(255, 0, 200, 255),
                boxBackgroundColor: Color.fromARGB(255, 164, 241, 255),
                textStyle: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 200.0,
              ),
            ),
            Lottie.asset('lib/assets/loading2.json', width: 350),
          ],
        ),
      ),
    );
@override
Widget AppDrawer(BuildContext context) {
  return Container(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            child: Container(
              width: 90,
              child: Center(
                child: Image.asset("lib/assets/logoport.png"),
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.white,
          ),
          title: Text(
            'Menus restaurant',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onTap: () {
            _gotonextpage(context, MyPage2());
          },
        ),

        ListTile(
          leading: Icon(
            Icons.note_add,
            color: Colors.white,
          ),
          title: Text('historique',
              style: TextStyle(
                color: Colors.white,
              )),
          onTap: () {
            _gotonextpage(context, MyPage3());
          },
        ),
        ListTile(
          leading: Icon(
            Icons.lock_clock,
            color: Colors.white,
          ),
          title: Text('Renouveler Mot de passe',
              style: TextStyle(
                color: Colors.white,
              )),
          onTap: () {
            BlocProvider.of<Panierbloc>(context).add((PanierResetEvent()));
            _gotonextpage(context, MyPage4());
          },
        ),
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          title: Text('Quitter',
              style: TextStyle(
                color: Colors.white,
              )),
          onTap: () {
            BlocProvider.of<Panierbloc>(context).add((PanierResetEvent()));
            _gotonextpage(context, MyPage());
          },
        ),
        // Ajoutez d'autres options ici
      ],
    ),
  );
}

@override
Widget Loading(context) => Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 255, 122, 122),
      height: 800,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              child: TextLiquidFill(
                text: 'chargement ... ',
                waveColor: Color.fromARGB(255, 254, 0, 68),
                boxBackgroundColor: const Color.fromARGB(255, 255, 122, 122),
                textStyle: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 200.0,
              ),
            ),
            Lottie.asset('lib/assets/loading.json', width: 350),
          ],
        ),
      ),
    );

void _gotonextpage(BuildContext context, Widget nextPage) async {
  Navigator.pushReplacement(
      context,
      PageTransition(
          type: PageTransitionType.leftToRightWithFade, child: nextPage));
  // Autres opérations à effectuer après l'affichage de QuickAlert
}

void _refreshpage(BuildContext context, Widget nextPage) async {
  await Future.delayed(const Duration(milliseconds: 800));
  Navigator.pushReplacement(
      context, PageTransition(type: PageTransitionType.fade, child: nextPage));
  // Autres opérations à effectuer après l'affichage de QuickAlert
}

  // Autres opérations à effectuer après l'affichage de QuickAlert

