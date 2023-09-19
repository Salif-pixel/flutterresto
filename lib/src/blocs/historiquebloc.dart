import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/src/repository/HistoriqueCommande_repository.dart';

import '../models/HistoriqueCommande_model.dart';
import '../models/LigneCommande_model.dart';
import 'historique_event.dart';
import 'historique_state.dart';

class Historiquebloc extends Bloc<Historique_Event, Historique_State> {
  Historiquebloc()
      : super(HistoriqueInitialState(
            ListeDetailCommande: [], ListeCommande: [])) {
    on<ListeHistoriqueEvent>((event, emit) async {
      emit(HistoriqueLoadingState(
          ListeCommande: state.ListeCommande,
          ListeDetailCommande: state.ListeDetailCommande));
      try {
        List<Commande> Commandeliste =
            await HistoriqueRepository().ListeCommande(event.matricule);

        emit(HistoriqueSuccessState(
          ListeCommande: Commandeliste,
          ListeDetailCommande: state.ListeDetailCommande,
        ));
      } catch (e) {
        emit(HistoriqueErrorState(
          ListeCommande: state.ListeCommande,
          message: e.toString(),
          ListeDetailCommande: state.ListeDetailCommande,
        ));
      }
    });
    on<AnnulerHistoriqueEvent>(
      (event, emit) async {
        try {
          String response =
              await HistoriqueRepository().AnnulerCommande(event.idCommande);
          List<Commande> Commandeliste =
              await HistoriqueRepository().ListeCommande(event.matricule);

          emit(HistoriqueSuccessState(
            ListeCommande: Commandeliste,
            ListeDetailCommande: state.ListeDetailCommande,
          ));
        } catch (e) {
          emit(HistoriqueErrorState(
            message: e.toString(),
            ListeDetailCommande: state.ListeDetailCommande,
            ListeCommande: [],
          ));
        }
      },
    );
    on<ListeDetailHistoriqueEvent>((event, emit) async {
      emit(HistoriqueLoadingState(
          ListeCommande: state.ListeCommande,
          ListeDetailCommande: state.ListeDetailCommande));
      try {
        List<LigneCommande> LigneCommandeliste =
            await HistoriqueRepository().DetailCommande(event.idCommande);

        emit(HistoriqueSuccessState(
          ListeCommande: state.ListeCommande,
          ListeDetailCommande: LigneCommandeliste,
        ));
      } catch (e) {
        emit(HistoriqueErrorState(
            message: e.toString(), ListeDetailCommande: [], ListeCommande: []));
      }
    });
  }
}
