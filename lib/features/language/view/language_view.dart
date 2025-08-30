import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flaapp/features/language/widget/language_card.dart';
import 'package:flaapp/features/level/view/level_page.dart';
import 'package:flaapp/utils/constant/strings/image.dart';
import 'package:flaapp/utils/constant/theme/colors.dart';
import 'package:flaapp/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(LanguageInitRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LanguageBloc, LanguageState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == LanguageStatus.success) {
            context.goNamed(LevelPage.route);
          }
          if (state.status == LanguageStatus.failed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return state.status == LanguageStatus.loading
              ? Scaffold(
                  body: Center(
                    child: const CircularProgressIndicator(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: ColorTheme.tBlueColor,
                    leading: SizedBox(),
                  ),
                  backgroundColor: ColorTheme.tBlueColor,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 48.0),
                        child: Text(
                          "Let's Learn!",
                          style: theme.textTheme.titleLarge!.copyWith(
                            color: ColorTheme.tWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Image.asset(
                            PngImage.books,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24.0),
                          decoration: BoxDecoration(
                            color: ColorTheme.tWhiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(48.0),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 48.0, left: 12.0),
                                  child: Text(
                                    "Choose the language which you want to learn",
                                    style:
                                        theme.textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                ...state.languages.map(
                                  (language) => LanguageCard(
                                    language: language,
                                    state: state,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                state.status == LanguageStatus.loading
                                    ? const CircularProgressIndicator()
                                    : PrimaryButton(
                                        onTap: () => context
                                            .read<LanguageBloc>()
                                            .add(LanguageChangeRequested(
                                                language:
                                                    state.selectedLanguage)),
                                        label: "Continue",
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
