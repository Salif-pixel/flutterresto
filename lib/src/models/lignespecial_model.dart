class LigneCommandeSpecial {
  String? idRestaurant;
  String? idProduit;
  String? matricule;

  String? libelleProduit;
  int? prixAvecSubvention;
  String? quantite;

  LigneCommandeSpecial({
    this.idRestaurant,
    this.idProduit,
    this.matricule,
    this.libelleProduit,
    this.prixAvecSubvention,
    this.quantite,
  });

  LigneCommandeSpecial.fromJson(Map<String, dynamic> json) {
    idRestaurant = json['idRestaurant'];
    idProduit = json['idProduit'];
    matricule = json['matricule'];

    libelleProduit = json['libelleProduit'];
    prixAvecSubvention = json['prixAvecSubvention'];
    quantite = json['quantite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['idRestaurant'] = this.idRestaurant;
    data['idProduit'] = this.idProduit;
    data['matricule'] = this.matricule;

    data['libelleProduit'] = this.libelleProduit;
    data['prixAvecSubvention'] = this.prixAvecSubvention;
    data['quantite'] = this.quantite;

    return data;
  }
}
