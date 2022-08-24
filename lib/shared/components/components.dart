import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:la_vie/modules/la_vie/login/SignInPage.dart';
import 'package:la_vie/modules/la_vie/login/cubit/cubit.dart';

import '../../modules/la_vie/login/cubit/states.dart';
import 'constants.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Primary,
  TextStyle? textStyle,
  bool isUpperCase = false,
  double radius = 5.0,
  required Function onPress,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: () {
          onPress();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: textStyle,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  required Function onPressed,
  required String text,
  TextAlign? textAlign,
  TextStyle? textStyle,
  bool wrappedWithContainer = true,
}) =>
    Flexible(
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: wrappedWithContainer
            ? Container(
                padding: EdgeInsets.only(bottom: 5.0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 3.0,
                  color: Primary,
                ))),
                child: Text(
                  text,
                  style: textStyle,
                  textAlign: textAlign,
                ),
              )
            : Text(
                text,
                style: textStyle,
                textAlign: textAlign,
              ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  TextInputAction? textInputAction,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  String? label,
  IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) =>
    Flexible(
      child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        validator: validate,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );

Widget loginForm({
  // ignore: non_constant_identifier_names
  required BuildContext context,
  required LaVieLoginStates state,
  required GlobalKey<FormState> formKey,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) =>
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "Email",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validate: (value) {
                  if (value!.isEmpty) return "Please Enter Email Address";
                },
                onChange: (value) {
                  print(value);
                },
                onSubmit: (value) {
                  print("Submitted" + value);
                }),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Text(
                "Password",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
              controller: passwordController,
              isPassword: true,
              textInputAction: TextInputAction.done,
              type: TextInputType.visiblePassword,
              onChange: (value) {
                print(value);
              },
              validate: (value) {
                if (value!.isEmpty) return "Please Enter Password ";
              },
              onSubmit: (value) async {
                if (formKey.currentState!.validate()) {
                  LaVieLoginCubit.get(context).userLogin(
                    password: passwordController.text,
                    email: emailController.text,
                  );
                  print("Lol I'm here");
                  print(LaVieLoginCubit.get(context).userlogin);
                }
              },
            ),
            SizedBox(
              height: 35,
            ),
            ConditionalBuilder(
              condition: state is! LaVieLoginLoadingState,
              builder: (context) => defaultButton(
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    LaVieLoginCubit.get(context).userLogin(
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
                text: "Login",
                textStyle: textStyleDefault,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: Line,
                  ),
                  Text(
                    " or continue with ",
                    style: TextStyle(color: Line),
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: Line,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){SignIn();},
                  icon: Container(
                    width: 33,
                    height: 33,
                    child: Image(
                      image: AssetImage(
                        "assets/images/google/go.png",
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    width: 15,
                    height: 25,
                    child: Image(
                      image: AssetImage("assets/images/facebook/fac.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 5,
            ),
            Container(
              alignment: AlignmentDirectional.bottomStart,
              child: Image(
                image: AssetImage("assets/images/revLeaves.png"),
              ),
            ),
          ],
        ),
      ),
    );

Widget signUpForm({
  // ignore: non_constant_identifier_names
  required BuildContext context,
  required LaVieLoginStates state,
  required GlobalKey<FormState> formKey,
  required TextEditingController firstNameController,
  required TextEditingController lastNameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) =>
    SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 15.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Text(
                "First Name",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
              controller: firstNameController,
              textInputAction: TextInputAction.next,
              type: TextInputType.name,
              validate: (value) {
                if (value!.isEmpty) return "Please Enter First Name";
              },
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Text(
                "Last Name",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
              textInputAction: TextInputAction.next,
              controller: lastNameController,
              type: TextInputType.name,
              validate: (value) {
                if (value!.isEmpty) return "Please Enter Last Name";
              },
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Text(
                "Email",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              type: TextInputType.emailAddress,
              validate: (value) {
                if (value!.isEmpty) return "Please Enter Email Address";
              },
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              child: Text(
                "Password",
                style: textStyleGreyMed,
              ),
              alignment: AlignmentDirectional.centerStart,
            ),
            SizedBox(
              height: 5,
            ),
            defaultFormField(
              controller: passwordController,
              type: TextInputType.visiblePassword,
              isPassword: true,
              textInputAction: TextInputAction.done,
              validate: (value) {
                if (value!.isEmpty) return "Please Enter Password ";
              },
              onSubmit: (value) async {
                if (formKey.currentState!.validate()) {
                  LaVieLoginCubit.get(context).signUp(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      password: passwordController.text,
                      email: emailController.text);
                }
                print("Lol I'm not here");
                print(LaVieLoginCubit.get(context).usersignUp);
              },
            ),
            SizedBox(
              height: 35,
            ),
            ConditionalBuilder(
              condition: state is! LaVieLoginLoadingState,
              builder: (context) => defaultButton(
                onPress: () async {
                  if (formKey.currentState!.validate()) {
                    LaVieLoginCubit.get(context).signUp(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        password: passwordController.text,
                        email: emailController.text);
                  }
                  print("Lol I'm not here");
                  print(LaVieLoginCubit.get(context).usersignUp);
                },
                text: "Sign Up",
                textStyle: textStyleDefault,
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            SizedBox(
              height: 35,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: Line,
                  ),
                  Text(
                    " or continue with ",
                    style: TextStyle(color: Line),
                  ),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width / 3.5,
                    color: Line,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: (){SignIn();},
                  icon: Container(
                    width: 33,
                    height: 33,
                    child: Image.asset("assets/images/google/go.png"),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Container(
                    width: 15,
                    height: 25,
                    child: Image(
                      image: AssetImage("assets/images/facebook/fac.png"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.height / 5,
            ),
            Container(
              alignment: AlignmentDirectional.bottomStart,
              child: Image(
                image: AssetImage("assets/images/revLeaves.png"),
              ),
            ),
          ],
        ),
      ),
    );

