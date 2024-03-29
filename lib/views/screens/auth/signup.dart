import 'package:flaapp/services/constant/theme/colors.dart';
import 'package:flaapp/services/extensions/email_validator.dart';
import 'package:flaapp/services/functions/nav.dart';
import 'package:flaapp/services/networks/auth.dart';
import 'package:flaapp/views/screens/auth/login.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flaapp/views/widgets/fields/primary_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static String route = "/signup";

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    final GlobalKey<FormFieldState> emailKey = GlobalKey();
    final GlobalKey<FormFieldState> passwordKey = GlobalKey();
    final GlobalKey<FormState> formKey = GlobalKey();
    final ThemeData theme = Theme.of(context);
    final Auth auth = Provider.of<Auth>(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      key: scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        child: Form(
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
                        "Create your Account",
                        style: theme.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18.0),
                      PrimaryTextField(
                        controller: Auth.name,
                        label: "Username",
                        hintText: "Juan Dela Cruz",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "This field is required.";
                          }
                          return null;
                        },
                      ),
                      PrimaryTextField(
                        key: emailKey,
                        controller: Auth.email,
                        label: "Email",
                        hintText: "example@gmail.com",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "This field is required.";
                          } else if (!val.isValidEmail()) {
                            return "This email is incorrect.";
                          }
                          return null;
                        },
                      ),
                      PrimaryTextField(
                        key: passwordKey,
                        controller: Auth.password,
                        label: "Password",
                        isPassword: true,
                        hintText: "Password",
                        onChanged: (val) {},
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "This field is required";
                          } else if (val.length < 6) {
                            return "Password field is short.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12.0),
                      PrimaryButton(
                        label: "Sign up",
                        onTap: () async {
                          await auth.signup().then((value) {
                            nav.pushScreen(context, screen: const LoginScreen());
                          });
                        },
                      ),
                      const SizedBox(height: 100.0),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Color(0xFF787878),
                          ),
                          text: "Already have an account? ",
                          children: [
                            TextSpan(
                              text: "LOGIN",
                              style: theme.textTheme.bodyMedium!.copyWith(
                                color: ColorTheme.tBlueColor,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => nav.pushScreen(context, screen: const LoginScreen())
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
      ),
    );
  }
}
