// ignore: file_names
import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/src/blocs/user_Auth_state.dart';
import 'package:flutter_application_1/src/blocs/user_Auth_event.dart';
import 'package:flutter_application_1/src/models/User_model.dart';
import 'package:flutter_application_1/src/repository/User_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAuthbloc extends Bloc<User_Auth_Event, User_Auth_State> {
  UserAuthbloc() : super(UserInitialState(agent: Agent())) {
    on<UserEvent>((event, emit) async {
      emit(UserILoadingState(agent: state.agent));
      try {
        if (event.mail == "" || event.password == "") {
          emit(UserErrorState(
              agent: state.agent, message: "Veuillez remplir tous les champs"));
        } else {
          Agent agent1 =
              await UserRepository().Login(event.mail, event.password);
          emit(UserSucessState(agent: agent1));
        }
      } catch (e) {
        emit(UserErrorState(
          message: e.toString().contains("406")
              ? "cet utilisateur n'existe pas"
              : e.toString(),
          agent: state.agent,
        ));
      }
    });
    on<UserRefreshEvent>((event, emit) async {
      emit(UserILoadingState(agent: state.agent));
      try {
        if (event.password == "" ||
            event.Npassword == "" ||
            event.Npassword1 == "") {
          emit(UserErrorState(
              agent: state.agent, message: "Veuillez remplir tous les champs"));
        } else if (event.Npassword == event.Npassword1) {
          Agent agent1 = await UserRepository().passwordconfirm(
              event.mail, event.password, event.Npassword, event.Npassword1);
          emit(UserSucessState(agent: agent1));
        } else {
          throw Exception("Les deux mots de passe ne sont pas identiques");
        }
      } catch (e) {
        emit(UserErrorState(
          message: e.toString().contains("406")
              ? "cet utilisateur n'existe pas"
              : e.toString(),
          agent: state.agent,
        ));
      }
    });
    on<UserinitialEvent>((event, emit) {
      emit(UserInitialState(agent: state.agent));
    });
  }
}
