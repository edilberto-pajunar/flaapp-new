import 'package:auto_route/auto_route.dart';
import 'package:flaapp/bloc/auth/auth_bloc.dart';
import 'package:flaapp/cubit/login/login_cubit.dart';
import 'package:flaapp/services/networks/admin.dart';
import 'package:flaapp/values/constant/theme/colors.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/views/screens/auth/signup.dart';
import 'package:flaapp/views/screens/flashcard/level.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static String route = "/login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormFieldState> emailKey = GlobalKey();
    final GlobalKey<FormFieldState> passwordKey = GlobalKey();
    final GlobalKey<FormState> formKey = GlobalKey();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final NavigationServices nav = NavigationServices();

    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              nav.replaceScreen(context, screen: const LevelScreen());
            }
          },
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login to your Account",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18.0),
                      PrimaryTextField(
                        key: emailKey,
                        controller: email,
                        label: "Email",
                        hintText: "example@gmail.com",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                      PrimaryTextField(
                        key: passwordKey,
                        controller: password,
                        label: "Password",
                        isPassword: true,
                        hintText: "Password",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                          } else if (val.length < 6) {
                            return "Password field is short.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      PrimaryButton(
                        label: "Login",
                        onTap: () async {
                          // await admin.saveWordToDb();
                          // await auth.login().then((user) {
                          //   if (Auth.email.text == "admin@gmail.com") {
                          //     nav.pushScreen(context, screen: const AdminScreen());
                          //   } else if (user != null) {
                          //     nav.pushScreen(context, screen: const LevelScreen());
                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(content: Text("Incorrect email/password.")),
                          //     );
                          //   }
                          // });
                          context.read<LoginCubit>().loginWithCredentials(
                                email: email.text,
                                password: password.text,
                              );
                        },
                      ),
                      const SizedBox(height: 100.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF787878),
                          ),
                          text: "Don't have an account yet? ",
                          children: [
                            TextSpan(
                                text: "SIGN UP",
                                style: theme.textTheme.bodyMedium!.copyWith(
                                  color: ColorTheme.tBlueColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => nav.pushScreen(context, screen: const SignupScreen())),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
