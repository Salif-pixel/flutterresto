import 'package:flutter_application_1/src/blocs/historique_event.dart';
import 'package:flutter_application_1/src/models/HistoriqueCommande_model.dart';
import 'package:flutter_application_1/src/models/LigneCommande_model.dart';

abstract class Historique_State {
  final List<LigneCommande> ListeDetailCommande;
  final List<Commande> ListeCommande;
  Historique_State(
      {required this.ListeDetailCommande, required this.ListeCommande});
}

class HistoriqueInitialState extends Historique_State {
  HistoriqueInitialState(
      {required super.ListeDetailCommande, required super.ListeCommande});
}

class HistoriqueLoadingState extends Historique_State {
  HistoriqueLoadingState(
      {required super.ListeDetailCommande, required super.ListeCommande});
}

class HistoriqueSuccessState extends Historique_State {
  HistoriqueSuccessState(
      {required super.ListeDetailCommande, required super.ListeCommande});
}

class HistoriqueErrorState extends Historique_State {
  String message;
  HistoriqueErrorState({
    required this.message,
    required super.ListeDetailCommande,
    required super.ListeCommande,
  });
}
