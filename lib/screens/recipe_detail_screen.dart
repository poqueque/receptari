import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receptari/models/recipe_detail.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/cooking_timer.dart';
import 'package:receptari/widgets/icon_text.dart';

import '../models/recipe.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<RecipeDetail> recipeFuture;

  @override
  void initState() {
    super.initState();
    recipeFuture = loadRecipeDetail();
  }

  Future<RecipeDetail> loadRecipeDetail() async {
    final response = await http.get(
      Uri.parse("https://xupxup.poquesoft.net/recipes/${widget.recipe.id}"),
    );
    final recipeDetail = recipeDetailFromJson(response.body);
    return recipeDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Receptari")),
      body: FutureBuilder(
        future: recipeFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error carregant la recepta"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final RecipeDetail recipeDetail = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      widget.recipe.imageUrl,
                      height: 250,
                      width: .infinity,
                      fit: .cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: AppStyles.imageShade,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Text(
                        widget.recipe.title,
                        style: AppStyles.mainTitle,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyles.tagBackground,
                          borderRadius: .circular(16),
                        ),
                        child: Text(widget.recipe.category),
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
                            text: '${widget.recipe.minutes} min',
                          ),
                          IconText(
                            icon: Icons.people_outline,
                            text: '${widget.recipe.servings} persones',
                          ),
                        ],
                      ),
                      AppStyles.bigSeparator,
                      CookingTimer(minutes: widget.recipe.minutes),
                      AppStyles.mediumSeparator,
                      Text("Ingredients", style: AppStyles.sectionTitle),
                      AppStyles.smallSeparator,
                      for (final ingredient in recipeDetail.ingredients)
                        Text(ingredient.toString()),
                      AppStyles.mediumSeparator,
                      Text("Preparació", style: AppStyles.sectionTitle),
                      AppStyles.smallSeparator,
                      for (var i = 0; i < recipeDetail.steps.length; i++)
                        Text("${i + 1}. ${recipeDetail.steps[i]}"),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
