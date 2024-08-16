import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/fields/primary_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormFieldState> emailKey = GlobalKey();
    final GlobalKey<FormFieldState> passwordKey = GlobalKey();
    final GlobalKey<FormState> formKey = GlobalKey();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

    final TextEditingController username = TextEditingController();
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
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
                      isLogin ? "Login to your Account" : "Create an Account",
                      style: theme.textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18.0),
                    Visibility(
                      visible: !isLogin,
                      child: PrimaryTextField(
                        controller: username,
                        label: "Username",
                        hintText: "username",
                      ),
                    ),
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
                      label: isLogin ? "Login" : "Sign up",
                      onTap: () async {
                        isLogin
                            ? context.read<AuthBloc>().add(AuthLoginAttempted(
                                  email: email.text,
                                  password: password.text,
                                ))
                            : context
                                .read<AuthBloc>()
                                .add(AuthCreateAccountAttempted(
                                  email: email.text,
                                  password: password.text,
                                  username: username.text,
                                ));
                      },
                    ),
                    const SizedBox(height: 100.0),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFF787878),
                        ),
                        text: !isLogin
                            ? "Already have an account? "
                            : "Don't have an account yet? ",
                        children: [
                          TextSpan(
                            text: !isLogin ? "LOGIN" : "SIGN UP",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: ColorTheme.tBlueColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isLogin = !isLogin;
                                  email.clear();
                                  username.clear();
                                  password.clear();
                                });
                              },
                          ),
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
    );
  }
}
