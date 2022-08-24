import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie/models/userData/UserModel.dart';

import 'package:la_vie/modules/la_vie/login/cubit/cubit.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import 'cubit/states.dart';

class Login extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordControllerSignUp = TextEditingController();
  var emailControllerSignUp = TextEditingController();
  UserData? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LaVieLoginCubit(),
      child: BlocConsumer<LaVieLoginCubit, LaVieLoginStates>(
        listener: (context, state) {
          if (state is LaVieLoginSuccessState) {
            user = LaVieLoginCubit.get(context).userlogin;
            print("trying to be user ");
            print(user);
          }
        },
        builder: (context, state) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    //leave image
                    Container(
                      alignment: AlignmentDirectional.topEnd,
                      child: Image(
                        image: AssetImage("assets/images/leaves.png"),
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.topCenter,
                      child: Image(
                        image: AssetImage("assets/images/logo75.png"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     defaultTextButton(
                    //         wrappedWithContainer:
                    //             !LaVieLoginCubit.get(context).login!,
                    //         text: 'Sign up',
                    //         onPressed: () {
                    //           if (LaVieLoginCubit.get(context).login! !=
                    //               false) {
                    //             LaVieLoginCubit.get(context)
                    //                 .changeEnteranceLayout();
                    //           }
                    //         },
                    //         textAlign: TextAlign.right,
                    //         textStyle: !LaVieLoginCubit.get(context).login!
                    //             ? textStyleGreen
                    //             : textStyleGrey),
                    //     defaultTextButton(
                    //         wrappedWithContainer:
                    //             LaVieLoginCubit.get(context).login!,
                    //         text: 'Login',
                    //         onPressed: () {
                    //           if (LaVieLoginCubit.get(context).login! != true) {
                    //             LaVieLoginCubit.get(context)
                    //                 .changeEnteranceLayout();
                    //           }
                    //         },
                    //         textAlign: TextAlign.left,
                    //         textStyle: LaVieLoginCubit.get(context).login!
                    //             ? textStyleGreen
                    //             : textStyleGrey),
                    //   ],
                    // ),


                          TabBar(indicatorColor: Primary,
                              isScrollable :true,
                              labelColor: Colors.black,
                              unselectedLabelColor: Secondary,
                              tabs: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Tab(
                                    child: Text("Sign Up",style: textStyleWithSize,),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Tab(
                                    child: Text("Login",style: textStyleWithSize,),

                                  ),
                                ),
                              ]),

                          Expanded(
                            child: TabBarView(
                                children: [
                                  signUpForm(
                                          context: context,
                                          state: state,
                                          formKey: formKey,
                                          firstNameController: firstNameController,
                                          lastNameController: lastNameController,
                                          emailController: emailControllerSignUp,
                                          passwordController: passwordControllerSignUp),
                                      loginForm(
                                          context: context,
                                          state: LaVieLoginCubit.get(context).state,
                                          formKey: formKey,
                                          emailController: emailController,
                                          passwordController: passwordController),
                                ]),
                          ),
                    // ConditionalBuilder(
                    //     condition: LaVieLoginCubit.get(context).login == true,
                    //     builder: (context) => loginForm(
                    //         context: context,
                    //         state: LaVieLoginCubit.get(context).state,
                    //         formKey: formKey,
                    //         emailController: emailController,
                    //         passwordController: passwordController),
                    //     fallback: (context) => signUpForm(
                    //         context: context,
                    //         state: state,
                    //         formKey: formKey,
                    //         firstNameController: firstNameController,
                    //         lastNameController: lastNameController,
                    //         emailController: emailControllerSignUp,
                    //         passwordController: passwordControllerSignUp),),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
