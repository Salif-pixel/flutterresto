import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/src/blocs/panier_event.dart';
import 'package:flutter_application_1/src/blocs/panier_state.dart';
import 'package:flutter_application_1/src/repository/Panier_repository.dart';

import '../models/lignespecial_model.dart';

class Panierbloc extends Bloc<Panier_Event, Panier_State> {
  Panierbloc() : super(PanierInitialState(ligneCommandes: [])) {
    on<PanierAjoutEvent>((event, emit) {
      if (state.ligneCommandes.isEmpty) {
        state.ligneCommandes.add(event.ligneCommande);
        emit(PanierSucessState(ligneCommandes: state.ligneCommandes));
      } else if (state.ligneCommandes.isNotEmpty) {
        for (int i = 0; i < state.ligneCommandes.length; i++) {
          if (event.ligneCommande.idProduit ==
              state.ligneCommandes[i].idProduit) {
            emit(PanierErreurState(
                ligneCommandes: state.ligneCommandes,
                message: "Oops ce,produit figure déja dans votre panier"));
            break;
          }
          if ((i == state.ligneCommandes.length - 1) &&
              (event.ligneCommande != state.ligneCommandes[i])) {
            state.ligneCommandes.add(event.ligneCommande);
            emit(PanierSucessState(ligneCommandes: state.ligneCommandes));
            break;
          }
        }
      }
      //emit(PanierEtatState(ligneCommandes: state.ligneCommandes));
    });
    on<PanierSupprimerEvent>((event, emit) {
      state.ligneCommandes.remove(event.ligneCommande);
      emit(PanierEtatState(ligneCommandes: state.ligneCommandes));
    });
    on<PanierEtatEvent>((event, emit) {
      emit(PanierEtatState(ligneCommandes: state.ligneCommandes));
    });
    on<PanierUpdateEvent>((event, emit) {
      for (int i = 0; i < state.ligneCommandes.length; i++) {
        if (event.ligneCommande.idProduit ==
            state.ligneCommandes[i].idProduit) {
          state.ligneCommandes.remove(state.ligneCommandes[i]);
          state.ligneCommandes.add(event.ligneCommande);
          break;
        }
      }
      emit(PanierEtatState(ligneCommandes: state.ligneCommandes));
    });
    on<PanierValideEvent>((event, emit) async {
      // for (int i = 0; i < state.ligneCommandes.length; i++) {
      //   LigneCommandeSpecial temp = LigneCommandeSpecial();
      //   temp.libelleProduit = event.Listeligne[i].libelleProduit;
      //   temp.idRestaurant = event.Listeligne[i].idRestaurant;
      //   temp.idProduit = event.Listeligne[i].idProduit;
      //   temp.matricule = event.matricule;
      //   temp.prixAvecSubvention = event.Listeligne[i].prixAvecSubvention;
      //   temp.quantite = event.Listeligne[i].quantite.toString();
      //   event.ListeligneCommande.add(temp);
      //   list.add(temp);
      // }

      try {
        await PanierRepository().Validerpanier(event.ListeligneCommande);
        emit(PanierValideState(
            ligneCommandes: state.ligneCommandes,
            ListeligneCommande: event.ListeligneCommande));
      } catch (e) {
        emit(PanierErreurState(
            ligneCommandes: state.ligneCommandes, message: e.toString()));
      }
    });
    on<PanierResetEvent>((event, emit) async {
      emit(PanierInitialState(ligneCommandes: []));
    });
  }
}
