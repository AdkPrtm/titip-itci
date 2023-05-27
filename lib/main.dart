import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:titip_itci/bloc/cart_bloc.dart';
import 'package:titip_itci/bloc/infinite_list_bloc.dart';
import 'package:titip_itci/bloc/resi_bloc.dart';
import 'package:titip_itci/bloc/user_bloc.dart';
import 'package:titip_itci/views/screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => ResiBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => InfiniteListBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Titip Itci',
        routes: {
          '/': (context) => SplashScreen(),
          '/LoginScreen': (context) => LoginScreen(),
          '/MainScreen': (context) => MainScreen(),
          '/ConfirmationData': (context) => ConfirmationScreen(),
        },
      ),
    );
  }
}
