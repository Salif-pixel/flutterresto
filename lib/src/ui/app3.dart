import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_application_1/src/blocs/UserAuthbloc.dart';
import 'package:flutter_application_1/src/blocs/historique_event.dart';
import 'package:flutter_application_1/src/blocs/historique_state.dart';
import 'package:flutter_application_1/src/blocs/user_Auth_state.dart';
import 'package:flutter_application_1/src/ui/app.dart';
import 'package:flutter_application_1/src/ui/app2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:page_transition/page_transition.dart';

import '../blocs/historiquebloc.dart';
import '../blocs/panier_event.dart';
import '../blocs/panier_state.dart';
import '../blocs/panierbloc.dart';
import '../models/HistoriqueCommande_model.dart';
import '../models/LigneCommande_model.dart';
import '../models/lignespecial_model.dart';
import 'app4.dart';

class MyPage3 extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  String matricule = "";
  bool notif = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<Historiquebloc, Historique_State>(
      listener: (context, state) {
        if (state is HistoriqueErrorState) {
          return _Errorexception(context, state.message);
        }
      },
      child: BlocBuilder<UserAuthbloc, User_Auth_State>(
        builder: (context, state) {
          String matricule = state.agent.matricule.toString();
          BlocProvider.of<Historiquebloc>(context)
              .add(ListeHistoriqueEvent(matricule: matricule));

          return buildappDrawerbody(context, matricule);
        },
      ),
    );
  }

  @override
  Widget buildappDrawerbody(BuildContext context, String matr) {
    Future<void> handleRefresh() async {
      _refreshpage(context, MyPage3());
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
          title: AppbarMenu(context, matricule, notif),
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
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: 700,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: BlocBuilder<Historiquebloc, Historique_State>(
                  builder: (context, state) {
                    if (state is HistoriqueSuccessState) {
                      return buildcommande(context, state.ListeCommande, matr);
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildcommande(
      BuildContext context, List<Commande> listeCommande, String matricul) {
    return ListView.builder(
      itemCount: listeCommande.length,
      itemBuilder: (context, index) {
        index = listeCommande.length - 1 - index;
        // Determine the timeline color and icon based on the index
        Color timelineColor = listeCommande[index].statut == "EN_COURS"
            ? Color.fromARGB(255, 148, 148, 148)
            : listeCommande[index].statut == "ANNULE"
                ? Color.fromARGB(255, 255, 0, 0)
                : const Color.fromARGB(255, 90, 255, 95);
        IconData timelineIcon = listeCommande[index].statut == "EN_COURS"
            ? Icons.lock_clock
            : listeCommande[index].statut == "ANNULE"
                ? Icons.delete_forever
                : Icons.done;

        return SizedBox(
          height: 300,
          child: TimelineTile(
            isFirst: index == listeCommande.length - 1 ? true : false,
            isLast: index == 0 ? true : false,
            beforeLineStyle: LineStyle(color: timelineColor),
            indicatorStyle: IndicatorStyle(
              color: timelineColor,
              width: 50,
              iconStyle: IconStyle(
                iconData: timelineIcon,
                color: Colors.white,
              ),
            ),
            endChild: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 3),
                    color: Color.fromARGB(255, 148, 148, 148),
                  ),
                ],
                color: Color.fromARGB(255, 247, 247, 247),
              ),
              margin: EdgeInsets.only(left: 10, top: 50, bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(1),
                    child: Text(
                      listeCommande[index].dateCommande.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 6, 65), fontSize: 13),
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                      color: timelineColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                            ),
                            color: timelineColor,
                          ),
                        ),
                        Text(
                          "Commande ${index + 1}",
                          style: TextStyle(
                            color: timelineColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Total: ${listeCommande[index].total.toString()} F",
                          style: TextStyle(
                            color: timelineColor,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "${listeCommande[index].nomRestaurant.toString()}",
                          style: TextStyle(
                            color: timelineColor,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<Historiquebloc>(context).add(
                                      ListeDetailHistoriqueEvent(
                                          idCommande: listeCommande[index]
                                              .idCommande
                                              .toString(),
                                          matricule: matricul));
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BlocBuilder<Historiquebloc,
                                                Historique_State>(
                                            builder: (context, state) {
                                          return ListeDetailbuild(context,
                                              state.ListeDetailCommande);
                                        });
                                      });
                                },
                                icon: Icon(
                                  Icons.menu_book,
                                  color: Color.fromARGB(255, 31, 6, 158),
                                )),
                            timelineColor == Color.fromARGB(255, 148, 148, 148)
                                ? IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40),
                                                topRight: Radius.circular(40),
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  GestureDetector(
                                                    child: Container(
                                                      width: double.infinity,
                                                      color: Colors.red,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 158.9,
                                                              vertical: 16),
                                                      child: Center(
                                                        child: Text(
                                                          'Annuler ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      BlocProvider.of<
                                                                  Historiquebloc>(
                                                              context)
                                                          .add(AnnulerHistoriqueEvent(
                                                              idCommande:
                                                                  listeCommande[
                                                                          index]
                                                                      .idCommande
                                                                      .toString(),
                                                              matricule:
                                                                  matricul));

                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Container(
                                                        width: double.infinity,
                                                        color:
                                                            Colors.blueAccent,
                                                        child: Center(
                                                          child: Center(
                                                            child: Text(
                                                              'retour',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
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
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                    ))
                                : Text(''),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}

@override
Widget ListeDetailbuild(
    BuildContext context, List<LigneCommande> ListeDetailCommande) {
  return Container(
    height: 200,
    child: ListView.builder(
      itemCount: ListeDetailCommande.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ListeDetailCommande[index].code == "P_SEN"
                  ? Colors.amberAccent
                  : ListeDetailCommande[index].code == "DESRT"
                      ? Colors.pinkAccent
                      : ListeDetailCommande[index].code == "VIENN"
                          ? const Color.fromARGB(255, 221, 160, 138)
                          : ListeDetailCommande[index].code == "B_FRAI"
                              ? Colors.blueAccent
                              : ListeDetailCommande[index].code == "P_EUR"
                                  ? Color.fromARGB(255, 0, 58, 105)
                                  : ListeDetailCommande[index].code == "NR"
                                      ? Color.fromARGB(255, 0, 117, 61)
                                      : ListeDetailCommande[index].code ==
                                              "B_CHAU"
                                          ? Colors.brown
                                          : ListeDetailCommande[index].code ==
                                                  "P_AFR"
                                              ? Colors.orangeAccent
                                              : ListeDetailCommande[index]
                                                          .code ==
                                                      "P_DEJ"
                                                  ? Color.fromARGB(
                                                      255, 0, 238, 255)
                                                  : Color.fromARGB(
                                                      255, 14, 0, 75),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: ListTile(
                    leading: Icon(
                      ListeDetailCommande[index].code == "P_SEN"
                          ? Icons.rice_bowl
                          : ListeDetailCommande[index].code == "DESRT"
                              ? Icons.icecream
                              : ListeDetailCommande[index].code == "VIENN"
                                  ? Icons.breakfast_dining
                                  : ListeDetailCommande[index].code == "B_FRAI"
                                      ? Icons.water
                                      : ListeDetailCommande[index].code ==
                                              "P_EUR"
                                          ? Icons.local_pizza
                                          : ListeDetailCommande[index].code ==
                                                  "NR"
                                              ? Icons.food_bank
                                              : ListeDetailCommande[index]
                                                          .code ==
                                                      "B_CHAU"
                                                  ? Icons.free_breakfast
                                                  : ListeDetailCommande[index]
                                                              .code ==
                                                          "P_AFR"
                                                      ? Icons.restaurant_menu
                                                      : ListeDetailCommande[
                                                                      index]
                                                                  .code ==
                                                              "P_DEJ"
                                                          ? Icons
                                                              .breakfast_dining
                                                          : Icons.restaurant,
                      size: 30,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    title: Text(
                      ListeDetailCommande[index].libelleProduit.toString(),
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    subtitle: Text(
                      "${ListeDetailCommande[index].prixAvecSubvention} F",
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    ListeDetailCommande[index].quantite.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

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
            Icons.padding,
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
            _gotonextpage(context, MyPage());
          },
        ),
        // Ajoutez d'autres options ici
      ],
    ),
  );
}

Widget AppbarMenu(BuildContext context, String matricule, bool notif) {
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
                return Text(
                  "${state.agent.prenom.toString()} ${state.agent.nom.toString()}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                );
              },
            ),
          )
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
                return Text(
                  state.agent.solde.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.white),
                );
              },
            ),
          )
        ],
      ),
    ],
  );
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

void _gotonextpage(BuildContext context, Widget nextPage) {
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
