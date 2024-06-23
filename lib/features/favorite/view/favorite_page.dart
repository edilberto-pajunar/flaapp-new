import 'package:flaapp/features/favorite/view/favorite_view.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  static String route = "favorite_page_route";
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoriteView();
  }
}
