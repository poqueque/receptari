import 'package:flutter/material.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/icon_text.dart';

import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receptari"),
        backgroundColor: AppStyles.primary,
        foregroundColor: AppStyles.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Image.network(
              "https://i.blogs.es/19c40e/penne/1366_2000.jpg",
              height: 250,
              width: .infinity,
              fit: .cover,
            ),
            Padding(
              padding: .all(16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(recipe.title, style: AppStyles.mainTitle),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      IconText(
                        icon: Icons.timer_outlined,
                        text: '${recipe.minutes} min',
                      ),
                      IconText(
                        icon: Icons.people_outline,
                        text: '${recipe.servings} persones',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyles.tagBackground,
                          borderRadius: .circular(16),
                        ),
                        child: Text(recipe.category),
                      ),
                    ],
                  ),
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
