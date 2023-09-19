class Agent {
  String? matricule;
  String? mail;
  String? login;
  String? password;
  String? nom;
  String? prenom;
  int? solde;
  int? totalConsMensuelle;
  bool? actif;
  String? typeAgent;

  Agent(
      {this.matricule,
      this.mail,
      this.login,
      this.password,
      this.nom,
      this.prenom,
      this.solde,
      this.totalConsMensuelle,
      this.actif,
      this.typeAgent});

  Agent.fromJson(Map<String, dynamic> json) {
    matricule = json['matricule'];
    mail = json['mail'];
    login = json['login'];
    password = json['password'];
    nom = json['nom'];
    prenom = json['prenom'];
    solde = json['solde'];
    totalConsMensuelle = json['totalConsMensuelle'];
    actif = json['actif'];
    typeAgent = json['typeAgent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matricule'] = this.matricule;
    data['mail'] = this.mail;
    data['login'] = this.login;
    data['password'] = this.password;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['solde'] = this.solde;
    data['totalConsMensuelle'] = this.totalConsMensuelle;
    data['actif'] = this.actif;
    data['typeAgent'] = this.typeAgent;
    return data;
  }
}
