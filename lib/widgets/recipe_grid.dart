import 'package:flutter/material.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/screens/recipe_detail_screen.dart';
import 'package:receptari/widgets/recipe_card.dart';

class RecipeGrid extends StatelessWidget {
  const RecipeGrid({super.key, required this.filteredRecipes});

  final List<Recipe> filteredRecipes;

  void openRecipe(BuildContext context, Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 250,
      ),
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = filteredRecipes[index];

        return RecipeCard(
          recipe: recipe,
          onTap: () {
            openRecipe(context, recipe);
          },
        );
      },
    );
  }
}
