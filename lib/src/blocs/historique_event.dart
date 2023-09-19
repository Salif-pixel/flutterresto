abstract class Historique_Event {}

class ListeHistoriqueEvent extends Historique_Event {
  final String matricule;
  ListeHistoriqueEvent({required this.matricule});
}

class AnnulerHistoriqueEvent extends Historique_Event {
  final String idCommande;
  final String matricule;
  AnnulerHistoriqueEvent({required this.idCommande, required this.matricule});
}

class ListeDetailHistoriqueEvent extends Historique_Event {
  final String idCommande;
  final String matricule;
  ListeDetailHistoriqueEvent(
      {required this.idCommande, required this.matricule});
}
