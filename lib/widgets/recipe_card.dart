import 'package:flutter/material.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/icon_text.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onTap,
  });

  final Recipe recipe;
  final bool isFavorite;
  final Function() onFavoritePressed;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
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
                      onPressed: onFavoritePressed,
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
