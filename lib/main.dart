import 'package:flutter_application_1/src/blocs/UserAuthbloc.dart';
import 'package:flutter_application_1/src/blocs/historiquebloc.dart';
import 'package:flutter_application_1/src/blocs/panierbloc.dart';

import 'package:flutter_application_1/src/blocs/restaurantbloc.dart';
import 'package:flutter_application_1/src/models/User_model.dart';

import 'package:flutter_application_1/src/ui/intro.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Use MultiBlocProvider instead of BlocProvider
      providers: [
        BlocProvider<Historiquebloc>(create: (context) => Historiquebloc()),
        BlocProvider<UserAuthbloc>(create: (context) => UserAuthbloc()),
        BlocProvider<Restaurantbloc>(create: (context) => Restaurantbloc()),
        BlocProvider<Panierbloc>(create: (context) => Panierbloc()),
        // Add more BlocProvider instances for other blocs if needed
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Intro(),
      ),
    );
  }
}
