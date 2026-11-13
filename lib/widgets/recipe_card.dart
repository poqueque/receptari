import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/providers/favorites_provider.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/icon_text.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe, required this.onTap});

  final Recipe recipe;
  final Function() onTap;

  void toggleFavorite(BuildContext context, Recipe recipe) {
    final favoritesProvider = context.read<FavoritesProvider>();
    final favorites = favoritesProvider.favorites;
    if (favorites.contains(recipe)) {
      favoritesProvider.remove(recipe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Has tret ${recipe.title} de "
            "les favorites",
          ),
          persist: false,
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Desfer',
            onPressed: () {
              favoritesProvider.add(recipe);
            },
          ),
        ),
      );
    } else {
      favoritesProvider.add(recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoritesProvider>().favorites.contains(
      recipe,
    );

    return Card(
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                recipe.imageUrl,
                width: .infinity,
                fit: .cover,
              ),
            ),
            Column(
              crossAxisAlignment: .center,
              children: [
                Text(
                  recipe.title,
                  maxLines: 1,
                  overflow: .ellipsis,
                  style: AppStyles.cardTitle,
                ),
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    IconText(
                      icon: Icons.timer_outlined,
                      text: '${recipe.minutes} min.',
                    ),
                    IconButton(
                      tooltip: isFavorite
                          ? "Treure de favorites"
                          : "Afegir a favorites",
                      onPressed: () => toggleFavorite(context, recipe),
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
