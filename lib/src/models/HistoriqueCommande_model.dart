class Commande {
  String? idCommande;
  String? dateCommande;
  String? nomRestaurant;
  int? quantite;
  String? statut;
  int? total;

  Commande(
      {this.idCommande,
      this.dateCommande,
      this.nomRestaurant,
      this.quantite,
      this.statut,
      this.total});

  Commande.fromJson(Map<String, dynamic> json) {
    idCommande = json['idCommande'];
    dateCommande = json['dateCommande'];
    nomRestaurant = json['nomRestaurant'];
    quantite = json['quantite'];
    statut = json['statut'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCommande'] = this.idCommande;
    data['dateCommande'] = this.dateCommande;
    data['nomRestaurant'] = this.nomRestaurant;
    data['quantite'] = this.quantite;
    data['statut'] = this.statut;
    data['total'] = this.total;
    return data;
  }
}
