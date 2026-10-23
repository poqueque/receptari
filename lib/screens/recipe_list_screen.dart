import 'package:flutter/material.dart';
import 'package:receptari/data/sample_recipes.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/recipe_card.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final Set<Recipe> favorites = {};
  String query = '';
  TextEditingController searchController = TextEditingController();

  void toggleFavorite(Recipe recipe) {
    if (favorites.contains(recipe)) {
      favorites.remove(recipe);
    } else {
      favorites.add(recipe);
    }
    setState(() {});
  }

  void clearSearch() {
    searchController.clear();
    query = '';
    setState(() {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Recipe> filteredRecipes = sampleRecipes
        .where(
          (element) =>
              element.title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Receptari"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: .center,
              children: [
                Icon(Icons.favorite, size: 40),
                Text('${favorites.length}', style: AppStyles.favoriteText),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                query = value;
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Cerca una recepta',
                prefixIcon: Icon(Icons.search),
                suffixIcon: query.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(Icons.close),
                        onPressed: clearSearch,
                      ),
              ),
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? Center(child: Text("No s'han trobat receptes"))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                    ),
                    itemCount: filteredRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = filteredRecipes[index];

                      return RecipeCard(
                        recipe: recipe,
                        isFavorite: favorites.contains(recipe),
                        onFavoritePressed: () => toggleFavorite(recipe),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
