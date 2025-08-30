import 'package:flaapp/app/app_locator.dart';
import 'package:flaapp/features/favorite/bloc/favorite_bloc.dart';
import 'package:flaapp/features/favorite/view/favorite_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatelessWidget {
  static String route = "favorite_page_route";
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<FavoriteBloc>(),
      child: const FavoriteView(),
    );
  }
}
