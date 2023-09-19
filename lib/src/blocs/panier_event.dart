import 'package:flutter_application_1/src/models/Menuplat_model.dart';
import 'package:flutter_application_1/src/models/lignespecial_model.dart';

import '../models/LigneCommande_model.dart';

abstract class Panier_Event {}

class PanierAjoutEvent extends Panier_Event {
  final LigneCommande ligneCommande;
  PanierAjoutEvent({required this.ligneCommande});
}

class PanierSupprimerEvent extends Panier_Event {
  final LigneCommande ligneCommande;
  PanierSupprimerEvent({required this.ligneCommande});
}

class PanierUpdateEvent extends Panier_Event {
  final LigneCommande ligneCommande;
  PanierUpdateEvent({required this.ligneCommande});
}

class PanierValideEvent extends Panier_Event {
  final List<LigneCommandeSpecial> ListeligneCommande;
  final List<LigneCommande> Listeligne;
  String matricule;
  PanierValideEvent(
      {required this.ListeligneCommande,
      required this.Listeligne,
      required this.matricule});
}

class PanierResetEvent extends Panier_Event {
  PanierResetEvent();
}

class PanierEtatEvent extends Panier_Event {
  PanierEtatEvent();
}
