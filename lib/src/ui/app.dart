import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/blocs/user_Auth_event.dart';
import 'package:flutter_application_1/src/ui/app2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/quickalert.dart';

import 'package:flutter_application_1/src/blocs/user_Auth_state.dart';
import 'package:flutter_application_1/src/blocs/UserAuthbloc.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class MyPage extends StatelessWidget {
  TextEditingController usercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> handleRefresh() async {
      _gotonextpage(context, MyPage());
      return await Future.delayed(Duration(seconds: 1));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: LiquidPullToRefresh(
        onRefresh: handleRefresh,
        color: Color.fromARGB(255, 15, 21, 65),
        backgroundColor: Color.fromARGB(255, 33, 192, 255),
        height: 150,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            height: 730,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: TextLiquidFill(
                    text: ' P   A   D ',
                    waveColor: Color.fromARGB(255, 15, 21, 65),
                    boxBackgroundColor: Color.fromARGB(255, 255, 255, 255),
                    textStyle: TextStyle(
                      fontSize: 80.0,
                      fontWeight: FontWeight.bold,
                    ),
                    boxHeight: 200.0,
                    boxWidth: double.infinity,
                  ),
                ),
                Image.asset(
                  'lib/assets/cadnat.png',
                  height: 150,
                  width: 150,
                ),
                buildinputuser(),
                buildinputpassword(),
                GestureDetector(
                  child: buildvalid(context),
                  onTap: () {
                    BlocProvider.of<UserAuthbloc>(context).add(UserEvent(
                      mail: usercontroller.text.toString(),
                      password: passwordcontroller.text.toString(),
                    ));
                  },
                ),
                BlocListener<UserAuthbloc, User_Auth_State>(
                  listener: (context, state) {
                    if (state is UserSucessState) {
                      _gotonextpage(context, MyPage2());
                    } else if (state is UserErrorState) {
                      _handleValidation(context, state.message);
                    }
                  },
                  child: Expanded(
                    child: BlocBuilder<UserAuthbloc, User_Auth_State>(
                      builder: (context, state) {
                        if (state is UserILoadingState) {
                          return Center(
                              child: Lottie.asset("lib/assets/refresh.json"));
                        }
                        return Container();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildinputuser() => Container(
        margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Couleur et opacité de l'ombre
              spreadRadius: 2, // Étalement de l'ombre
              blurRadius: 5, // Flou de l'ombre
              offset: Offset(0, 3), // Décalage de l'ombre (x, y)
            ),
          ],
        ),
        child: TextFormField(
          controller: usercontroller,
          decoration: InputDecoration(
              hintText: 'utilisateur',
              border: InputBorder.none,
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 15, 21, 65),
                size: 50,
              )),
        ),
      );

  Widget buildinputpassword() => Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.grey.withOpacity(0.5), // Couleur et opacité de l'ombre
              spreadRadius: 2, // Étalement de l'ombre
              blurRadius: 5, // Flou de l'ombre
              offset: Offset(0, 3), // Décalage de l'ombre (x, y)
            ),
          ],
        ),
        child: TextFormField(
          obscureText: true,
          controller: passwordcontroller,
          decoration: InputDecoration(
              hintText: 'mot de passe',
              border: InputBorder.none,
              icon: Icon(
                Icons.lock,
                color: Color.fromARGB(255, 15, 21, 65),
                size: 50,
              )),
        ),
      );
  @override
  Widget buildvalid(context) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 15, 21, 65),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                spreadRadius: 2,
                blurRadius: 2,
              )
            ]),
        margin: EdgeInsets.all(30),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Center(
          child: Text(
            'valider',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      );
}

void _handleValidation(BuildContext context, String message) {
  Future.delayed(Duration.zero, () {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops...',
      text: message,
    );
    // Autres opérations à effectuer après l'affichage de QuickAlert
  });
}

void _gotonextpage(BuildContext context, Widget nextPage) async {
  await Future.delayed(Duration(seconds: 1));
  Navigator.pushReplacement(
      context, PageTransition(type: PageTransitionType.fade, child: nextPage));
  // Autres opérations à effectuer après l'affichage de QuickAlert
}
