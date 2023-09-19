import 'package:flutter_application_1/src/models/User_model.dart';

abstract class User_Auth_State {
  Agent agent;
  User_Auth_State({required this.agent});
  void setagent(Agent newAgent) {
    agent = newAgent;
  }
}

class UserInitialState extends User_Auth_State {
  UserInitialState({required super.agent});
}

class UserILoadingState extends User_Auth_State {
  UserILoadingState({required super.agent});
}

class UserSucessState extends User_Auth_State {
  UserSucessState({required super.agent});

  void updateAgent(Agent newAgent) {
    setagent(newAgent);
  }
}

class UserErrorState extends User_Auth_State {
  final String message;
  UserErrorState({required super.agent, required this.message});
}
