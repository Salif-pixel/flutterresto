abstract class User_Auth_Event {}

class UserEvent extends User_Auth_Event {
  final String mail;
  final String password;

  UserEvent({required this.mail, required this.password});
}

class UserRefreshEvent extends User_Auth_Event {
  final String mail;
  final String password;
  final String Npassword;
  final String Npassword1;

  UserRefreshEvent(
      {required this.mail,
      required this.password,
      required this.Npassword,
      required this.Npassword1});
}

class UserinitialEvent extends User_Auth_Event {
  UserinitialEvent();
}
