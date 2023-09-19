import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/lignespecial_model.dart';

import '../models/LigneCommande_model.dart';

abstract class Panier_State {
  final List<LigneCommande> ligneCommandes;

  Panier_State({required this.ligneCommandes});
}

class PanierInitialState extends Panier_State {
  PanierInitialState({required List<LigneCommande> ligneCommandes})
      : super(ligneCommandes: ligneCommandes);
}

class PanierEtatState extends Panier_State {
  PanierEtatState({required List<LigneCommande> ligneCommandes})
      : super(ligneCommandes: ligneCommandes);
}

class PanierSucessState extends Panier_State {
  PanierSucessState({required super.ligneCommandes});
}

class PanierValideState extends Panier_State {
  final List<LigneCommandeSpecial> ListeligneCommande;
  PanierValideState(
      {required this.ListeligneCommande, required super.ligneCommandes});
}

class PanierErreurState extends Panier_State {
  String message;
  PanierErreurState({required super.ligneCommandes, required this.message});
}
