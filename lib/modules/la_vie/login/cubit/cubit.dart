import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/modules/la_vie/login/cubit/states.dart';

import '../../../../models/userData/UserModel.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class LaVieLoginCubit extends Cubit<LaVieLoginStates> {
  LaVieLoginCubit() : super(LaVieLoginInitialState());


  static LaVieLoginCubit get(context) => BlocProvider.of(context);
  bool? login = true;

  // IconData? suffix = Icons.visibility_off_outlined;
  // bool? isPassword = true;

  void changeEnteranceLayout()
  {
    login = !login!;

    emit(LaVieChangeEnteranceLayoutState());
  }

    UserData? userlogin;
    UserData? usersignUp;

  void userLogin ({
    required String email,
    required String password,
  })
  {
    emit(LaVieLoginLoadingState());

    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      print(value.data);
      userlogin = UserData.fromJson(value.data['user']);
      emit(LaVieLoginSuccessState(userlogin!));
    }).catchError((error)
    {
      print(error.toString());
      emit(LaVieLoginErrorState(error.toString()));
    });
  }
  void signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  })
  {
    emit(LaVieSignUpLoadingState());

    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
      },
    ).then((value)
    {
      print(value.data);
      usersignUp = UserData.fromJson(value.data['user']);
      emit(LaVieSignUpSuccessState(usersignUp!));
    }).catchError((error)
    {
      print(error.toString());
      emit(LaVieSignUpErrorState(error.toString()));
    });
  }

}