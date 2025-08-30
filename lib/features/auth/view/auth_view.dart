import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/features/wrapper/view/wrapper_page.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flaapp/widgets/fields/primary_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;
  final GlobalKey<FormBuilderState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == AuthStatus.success) {
            context.goNamed(WrapperPage.route);
          } else if (state.status == AuthStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${state.error}"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.status == AuthStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FormBuilder(
            key: formKey,
            onChanged: () => formKey.currentState?.save(),
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
                          isLogin
                              ? "Login to your Account"
                              : "Create an Account",
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 18.0),
                        Visibility(
                          visible: !isLogin,
                          child: PrimaryTextField(
                            label: "Username",
                            hintText: "username",
                            name: "username",
                          ),
                        ),
                        PrimaryTextField(
                          label: "Email",
                          hintText: "example@gmail.com",
                          name: "email",
                          required: true,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          name: "password",
                          label: "Password",
                          isPassword: true,
                          hintText: "Password",
                          required: true,
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
                            if (formKey.currentState!.saveAndValidate()) {
                              final value = formKey.currentState?.value ?? {};
                              isLogin
                                  ? context
                                      .read<AuthBloc>()
                                      .add(AuthLoginAttempted(
                                        email: value["email"],
                                        password: value["password"],
                                      ))
                                  : context
                                      .read<AuthBloc>()
                                      .add(AuthCreateAccountAttempted(
                                        email: value["email"],
                                        password: value["password"],
                                        username: value["username"],
                                      ));
                            }
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
                                      formKey.currentState?.reset();
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
          );
        },
      ),
    );
  }
}
