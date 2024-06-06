import 'package:flaapp/bloc/admin/admin_bloc.dart';
import 'package:flaapp/features/auth/bloc/auth_bloc.dart';
import 'package:flaapp/cubit/lang/lang_cubit.dart';
import 'package:flaapp/repository/auth/auth_repository.dart';
import 'package:flaapp/repository/database/database_repository.dart';
import 'package:flaapp/repository/translate/translate_repository.dart';
import 'package:flaapp/views/screens/admin/add_lesson_screen.dart';
import 'package:flaapp/views/screens/admin/add_level_screen.dart';
import 'package:flaapp/views/screens/admin/add_word_screen.dart';
import 'package:flaapp/views/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    void changeLanguage() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    context.read<LangCubit>().updateLanguage("en");
                  },
                  child: const Text("English"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<LangCubit>().updateLanguage("es");
                  },
                  child: const Text("Spanish"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<LangCubit>().updateLanguage("de");
                  },
                  child: const Text("German"),
                ),
              ],
            ),
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Admin"),
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              label: const Text("Choose language"),
              onPressed: () => changeLanguage(),
              icon: const Icon(
                Icons.language,
              ),
            ),
            TextButton.icon(
              label: Text(AppLocalizations.of(context)!.signOut),
              onPressed: () {
                context.read<AuthRepository>().signOut();
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            // if (state.status == AuthStatus.unauthenticated) {
            //   nav.replaceScreen(context, screen: const LoginScreen());
            // }
          },
          child: BlocProvider(
            create: (context) => AdminBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              translateRepository: context.read<TranslateRepository>(),
            )..add(const GetLevels()),
            child: BlocBuilder<AdminBloc, AdminState>(
              builder: (context, state) {
                if (state is AdminLoading) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is AdminLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PrimaryButton(
                            label: "Generate Word",
                            onTap: () {
                              context.read<DatabaseRepository>().updateWords();
                            },
                          ),
                          // PrimaryButton(
                          //   label: "Generate Level",
                          //   onTap: () {
                          //     context.read<DatabaseRepository>().setLevel();
                          //   },
                          // ),
                          Text(
                              "${AppLocalizations.of(context)!.chooseALevel}:"),
                          SizedBox(
                            child: DropdownButton<String>(
                              items: state.levelList.map((level) {
                                return DropdownMenuItem(
                                  value: level.label,
                                  child: Text(level.label),
                                );
                              }).toList(),
                              onChanged: (val) {
                                context
                                    .read<AdminBloc>()
                                    .add(UpdateLevel(level: val!));
                              },
                              value: state.level,
                            ),
                          ),
                          const SizedBox(height: 50.0),
                          PrimaryButton(
                            label: "Generate Lesson",
                            onTap: () {},
                          ),
                          Text(
                              "${AppLocalizations.of(context)!.chooseALesson}:"),
                          SizedBox(
                            child: DropdownButton<String>(
                              items: state.lessonList?.map((lesson) {
                                return DropdownMenuItem(
                                  value: lesson.label,
                                  child: Text(lesson.label),
                                );
                              }).toList(),
                              onChanged: (val) {
                                context
                                    .read<AdminBloc>()
                                    .add(UpdateLesson(lesson: val!));
                              },
                              value: state.lesson,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state.lesson != null &&
                                          state.level != null
                                      ? () {
                                          // nav.pushScreen(context,
                                          //     screen: const AddLevelScreen());
                                        }
                                      : null,
                                  child: Text(
                                    AppLocalizations.of(context)!.addALevel,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state.lesson != null &&
                                          state.level != null
                                      ? () {
                                          // nav.pushScreen(context,
                                          //     screen: AddLessonScreen(
                                          //       state: state,
                                          //     ));
                                        }
                                      : null,
                                  child: Text(
                                    AppLocalizations.of(context)!.addALesson,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: state.lesson != null &&
                                          state.level != null
                                      ? () {
                                          // nav.pushScreen(context,
                                          //     screen: AddWordScreen(
                                          //       state: state,
                                          //     ));
                                        }
                                      : null,
                                  child: Text(
                                    AppLocalizations.of(context)!.addAWord,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 50.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  "List of Words from ${state.level}-${state.lesson}",
                                  style: theme.textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              PrimaryButton(
                                onTap: () {
                                  context
                                      .read<AdminBloc>()
                                      .add(const UpdateWords());
                                },
                                label: "Fetch",
                              ),
                              const SizedBox(width: 12.0),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          _WordList(state: state),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Something went wrong."),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _WordList extends StatelessWidget {
  const _WordList({
    required this.state,
  });

  final AdminLoaded state;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.7,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: state.wordList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              children: state.wordList![index].translations.map((translation) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(translation),
                    ),
                    if (state.wordList![index].translations
                            .indexOf(translation) ==
                        0)
                      const Text("German"),
                    if (state.wordList![index].translations
                            .indexOf(translation) ==
                        1)
                      const Text("English"),
                    if (state.wordList![index].translations
                            .indexOf(translation) ==
                        2)
                      const Text("Spanish"),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
