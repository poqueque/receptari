import 'package:flutter/material.dart';
import 'package:receptari/data/sample_recipes.dart';
import 'package:receptari/widgets/recipe_card.dart';

class RecipeListScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Receptari")),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          final recipe = sampleRecipes[index];

          return RecipeCard(recipe: recipe);
        },
      ),
    );
  }
}
