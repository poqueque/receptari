import 'package:flutter/material.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/cooking_timer.dart';
import 'package:receptari/widgets/icon_text.dart';

import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Receptari")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                Image.network(
                  recipe.imageUrl,
                  height: 250,
                  width: .infinity,
                  fit: .cover,
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(gradient: AppStyles.imageShade),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Text(recipe.title, style: AppStyles.mainTitle),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppStyles.tagBackground,
                      borderRadius: .circular(16),
                    ),
                    child: Text(recipe.category),
                  ),
                ),
              ],
            ),
            Padding(
              padding: .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      IconText(
                        icon: Icons.timer_outlined,
                        text: '${recipe.minutes} min',
                      ),
                      IconText(
                        icon: Icons.people_outline,
                        text: '${recipe.servings} persones',
                      ),
                    ],
                  ),
                  AppStyles.bigSeparator,
                  CookingTimer(minutes: recipe.minutes),
                  AppStyles.mediumSeparator,
                  Text("Ingredients", style: AppStyles.sectionTitle),
                  AppStyles.smallSeparator,
                  for (final ingredient in recipe.ingredients)
                    Text("· $ingredient"),
                  AppStyles.mediumSeparator,
                  Text("Preparació", style: AppStyles.sectionTitle),
                  AppStyles.smallSeparator,
                  for (var i = 0; i < recipe.steps.length; i++)
                    Text("${i + 1}. ${recipe.steps[i]}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
