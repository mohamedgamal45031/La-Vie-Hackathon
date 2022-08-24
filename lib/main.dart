import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/modules/la_vie/login/cubit/cubit.dart';
import 'package:la_vie/shared/network/bloc_observer.dart';
import 'package:la_vie/shared/network/remote/dio_helper.dart';

import 'modules/la_vie/home/HomeScreen.dart';
import 'modules/la_vie/login/Login.dart';
import 'modules/la_vie/login/cubit/states.dart';
import 'modules/la_vie/login/cubit/cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LaVieLoginCubit(),
        child: BlocConsumer<LaVieLoginCubit, LaVieLoginStates>(
          builder: (context, state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: Login(),
          ),
          listener: (context, state) {},
        ),
      );
  }
}
