import 'package:cached_network_image/cached_network_image.dart';
import 'package:flaapp/admin/features/features/language/view/add_admin_language_page.dart';
import 'package:flaapp/features/language/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminLanguageView extends StatefulWidget {
  const AdminLanguageView({super.key});

  @override
  State<AdminLanguageView> createState() => _AdminLanguageViewState();
}

class _AdminLanguageViewState extends State<AdminLanguageView> {
  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(LanguageInitRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Languages"),
        actions: [
          IconButton(
            onPressed: () {
              context.pushNamed(AddAdminLanguagePage.route);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.languages.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final language = state.languages[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: language.flag ?? "",
                                width: 48.0,
                                height: 48.0,
                                placeholder: (context, url) => const SizedBox(),
                                errorWidget: (context, url, error) =>
                                    const SizedBox(),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(child: Text(language.language ?? "")),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
