import 'package:flutter/material.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/icon_text.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: .antiAlias,
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
              IconText(
                icon: Icons.timer_outlined,
                text: '${recipe.minutes} min.',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
