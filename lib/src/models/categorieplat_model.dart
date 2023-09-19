class Categorie {
  String? idCateg;
  String? libelleCateg;
  String? code;
  Resto? resto;

  Categorie({this.idCateg, this.libelleCateg, this.code, this.resto});

  Categorie.fromJson(Map<String, dynamic> json) {
    idCateg = json['idCateg'];
    libelleCateg = json['libelleCateg'];
    code = json['code'];
    resto = json['resto'] != null ? new Resto.fromJson(json['resto']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idCateg'] = this.idCateg;
    data['libelleCateg'] = this.libelleCateg;
    data['code'] = this.code;
    if (this.resto != null) {
      data['resto'] = this.resto!.toJson();
    }
    return data;
  }
}

class Resto {
  String? idRestaurant;
  String? nom;
  String? gerant;
  Null? genre;
  String? telephone;
  String? mail;
  Null? association;
  Null? zone;
  Null? adresse;
  Null? ville;
  Null? bp;
  Subvention? subvention;
  Null? montantSubvention;
  bool? etat;
  List<Parametress>? parametres;

  Resto(
      {this.idRestaurant,
      this.nom,
      this.gerant,
      this.genre,
      this.telephone,
      this.mail,
      this.association,
      this.zone,
      this.adresse,
      this.ville,
      this.bp,
      this.subvention,
      this.montantSubvention,
      this.etat,
      this.parametres});

  Resto.fromJson(Map<String, dynamic> json) {
    idRestaurant = json['idRestaurant'];
    nom = json['nom'];
    gerant = json['gerant'];
    genre = json['genre'];
    telephone = json['telephone'];
    mail = json['mail'];
    association = json['association'];
    zone = json['zone'];
    adresse = json['adresse'];
    ville = json['ville'];
    bp = json['bp'];
    subvention = json['subvention'] != null
        ? new Subvention.fromJson(json['subvention'])
        : null;
    montantSubvention = json['montantSubvention'];
    etat = json['etat'];
    if (json['parametres'] != null) {
      parametres = <Parametress>[];
      json['parametres'].forEach((v) {
        parametres!.add(new Parametress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idRestaurant'] = this.idRestaurant;
    data['nom'] = this.nom;
    data['gerant'] = this.gerant;
    data['genre'] = this.genre;
    data['telephone'] = this.telephone;
    data['mail'] = this.mail;
    data['association'] = this.association;
    data['zone'] = this.zone;
    data['adresse'] = this.adresse;
    data['ville'] = this.ville;
    data['bp'] = this.bp;
    if (this.subvention != null) {
      data['subvention'] = this.subvention!.toJson();
    }
    data['montantSubvention'] = this.montantSubvention;
    data['etat'] = this.etat;
    if (this.parametres != null) {
      data['parametres'] = this.parametres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subvention {
  String? idSubvention;
  String? libelleSubvention;
  int? montantSubvention;
  int? taux;
  bool? enVigueur;
  bool? etat;

  Subvention(
      {this.idSubvention,
      this.libelleSubvention,
      this.montantSubvention,
      this.taux,
      this.enVigueur,
      this.etat});

  Subvention.fromJson(Map<String, dynamic> json) {
    idSubvention = json['idSubvention'];
    libelleSubvention = json['libelleSubvention'];
    montantSubvention = json['montantSubvention'];
    taux = json['taux'];
    enVigueur = json['enVigueur'];
    etat = json['etat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idSubvention'] = this.idSubvention;
    data['libelleSubvention'] = this.libelleSubvention;
    data['montantSubvention'] = this.montantSubvention;
    data['taux'] = this.taux;
    data['enVigueur'] = this.enVigueur;
    data['etat'] = this.etat;
    return data;
  }
}

class Parametress {
  String? idParam;
  String? libelleParam;

  Parametress({this.idParam, this.libelleParam});

  Parametress.fromJson(Map<String, dynamic> json) {
    idParam = json['idParam'];
    libelleParam = json['libelleParam'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idParam'] = this.idParam;
    data['libelleParam'] = this.libelleParam;
    return data;
  }
}
