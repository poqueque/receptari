import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receptari/providers/favorites_provider.dart';
import 'package:receptari/widgets/recipe_grid.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.onClearFavorites});

  final Function() onClearFavorites;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Receptes Favorites"),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              tooltip: "Buidar les favorites",
              onPressed: onClearFavorites,
              icon: Icon(Icons.delete),
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(child: Text("No tens cap favorit"))
          : RecipeGrid(filteredRecipes: favorites.toList()),
    );
  }
}
