import 'package:flaapp/features/favorite/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(FavoriteInitRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: BlocConsumer<FavoriteBloc, FavoriteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state.status == FavoriteStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ListView.builder(
              itemCount: state.favorites.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final favorite = state.favorites[index];
                final itemNumber = index + 1;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("$itemNumber. ${favorite.word ?? ""}"),
                    ...favorite.translations?.map((translation) {
                          return Row(
                            children: [
                              Expanded(child: Text(translation.language ?? "")),
                              Expanded(
                                  child: Text(
                                translation.word ?? "",
                                textAlign: TextAlign.end,
                              )),
                            ],
                          );
                        }).toList() ??
                        [],
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
