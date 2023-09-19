class LigneCommande {
  String? id;
  String? idEnteteCommande;
  int? dateCommande;
  String? idRestaurant;
  String? nomRestaurant;
  String? telephoneRestaurant;
  String? zoneAgent;
  String? matricule;
  String? nomAgent;
  String? prenomAgent;
  String? idProduit;
  String? libelleProduit;
  String? modePaiement;
  String? idSubvention;
  String? statut;
  String? libelleCommande;
  int? quantite;
  int? prixAvecSubvention;
  int? prixSansSubvention;
  int? totalConsoMensuelle;
  int? bonusUnitaire;
  int? totalBonus;
  int? totalSansBonus;
  int? totalAvecBonus;
  int? totalCommande;
  bool? etatCommandeEnLigne;
  bool? etat;
  String? code;

  LigneCommande(
      {this.id,
      this.idEnteteCommande,
      this.dateCommande,
      this.idRestaurant,
      this.nomRestaurant,
      this.telephoneRestaurant,
      this.zoneAgent,
      this.matricule,
      this.nomAgent,
      this.prenomAgent,
      this.idProduit,
      this.libelleProduit,
      this.modePaiement,
      this.idSubvention,
      this.statut,
      this.libelleCommande,
      this.quantite,
      this.prixAvecSubvention,
      this.prixSansSubvention,
      this.totalConsoMensuelle,
      this.bonusUnitaire,
      this.totalBonus,
      this.totalSansBonus,
      this.totalAvecBonus,
      this.totalCommande,
      this.etatCommandeEnLigne,
      this.etat,
      this.code});

  LigneCommande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idEnteteCommande = json['idEnteteCommande'];
    dateCommande = json['dateCommande'];
    idRestaurant = json['idRestaurant'];
    nomRestaurant = json['nomRestaurant'];
    telephoneRestaurant = json['telephoneRestaurant'];
    zoneAgent = json['zoneAgent'];
    matricule = json['matricule'];
    nomAgent = json['nomAgent'];
    prenomAgent = json['prenomAgent'];
    idProduit = json['idProduit'];
    libelleProduit = json['libelleProduit'];
    modePaiement = json['modePaiement'];
    idSubvention = json['idSubvention'];
    statut = json['statut'];
    libelleCommande = json['libelleCommande'];
    quantite = json['quantite'];
    prixAvecSubvention = json['prixAvecSubvention'];
    prixSansSubvention = json['prixSansSubvention'];
    totalConsoMensuelle = json['totalConsoMensuelle'];
    bonusUnitaire = json['bonusUnitaire'];
    totalBonus = json['totalBonus'];
    totalSansBonus = json['totalSansBonus'];
    totalAvecBonus = json['totalAvecBonus'];
    totalCommande = json['totalCommande'];
    etatCommandeEnLigne = json['etatCommandeEnLigne'];
    etat = json['etat'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idEnteteCommande'] = this.idEnteteCommande;
    data['dateCommande'] = this.dateCommande;
    data['idRestaurant'] = this.idRestaurant;
    data['nomRestaurant'] = this.nomRestaurant;
    data['telephoneRestaurant'] = this.telephoneRestaurant;
    data['zoneAgent'] = this.zoneAgent;
    data['matricule'] = this.matricule;
    data['nomAgent'] = this.nomAgent;
    data['prenomAgent'] = this.prenomAgent;
    data['idProduit'] = this.idProduit;
    data['libelleProduit'] = this.libelleProduit;
    data['modePaiement'] = this.modePaiement;
    data['idSubvention'] = this.idSubvention;
    data['statut'] = this.statut;
    data['libelleCommande'] = this.libelleCommande;
    data['quantite'] = this.quantite;
    data['prixAvecSubvention'] = this.prixAvecSubvention;
    data['prixSansSubvention'] = this.prixSansSubvention;
    data['totalConsoMensuelle'] = this.totalConsoMensuelle;
    data['bonusUnitaire'] = this.bonusUnitaire;
    data['totalBonus'] = this.totalBonus;
    data['totalSansBonus'] = this.totalSansBonus;
    data['totalAvecBonus'] = this.totalAvecBonus;
    data['totalCommande'] = this.totalCommande;
    data['etatCommandeEnLigne'] = this.etatCommandeEnLigne;
    data['etat'] = this.etat;
    data['code'] = this.code;
    return data;
  }
}
