import 'package:flutter/material.dart';
import 'package:receptari/models/category.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/repositories/api_recipe_repository.dart';
import 'package:receptari/repositories/recipe_repository.dart';
import 'package:receptari/screens/recipe_detail_screen.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/app_drawer.dart';
import 'package:receptari/widgets/recipe_card.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({
    super.key,
    required this.favorites,
    required this.onFavoritePressed,
  });

  final Set<Recipe> favorites;
  final Function(Recipe recipe) onFavoritePressed;

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  String query = '';
  TextEditingController searchController = TextEditingController();
  List<Recipe> apiRecipes = [];
  bool isLoading = false;
  Category? selectedCategory;
  late Future<List<Category>> categoriesFuture;
  final RecipeRepository recipeRepository = ApiRecipeRepository();

  void clearSearch() async {
    searchController.clear();
    query = '';
    await loadRecipes();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadRecipes();
    categoriesFuture = loadCategories();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadRecipes() async {
    debugPrint("Buscando $query");
    isLoading = true;
    setState(() {});
    try {
      apiRecipes = await recipeRepository.getRecipes(query, selectedCategory?.id);
    } catch (e, stackTrace) {
      if (!mounted) return;
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No s'han pogut carregar les receptes"),
          action: SnackBarAction(label: "Reintentar", onPressed: loadRecipes),
        ),
      );
    }
    isLoading = false;
    setState(() {});
  }

  Future<List<Category>> loadCategories() async {
    try {
      debugPrint("Carregant categories...");
      return await recipeRepository.getCategories();
    } catch (e) {
      if (!mounted) return [];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No s'han pogut carregar les categories"),
          action: SnackBarAction(
            label: "Reintentar",
            onPressed: loadCategories,
          ),
        ),
      );
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final List<Recipe> filteredRecipes = apiRecipes.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Receptari"),
        actions: [
          IconButton(
            onPressed: showFilters,
            icon: Badge(
              backgroundColor: AppStyles.onPrimary,
              textColor: AppStyles.primary,
              isLabelVisible: selectedCategory != null,
              child: Icon(Icons.filter_list),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Stack(
              alignment: .center,
              children: [
                Icon(Icons.favorite, size: 40),
                Text(
                  '${widget.favorites.length}',
                  style: AppStyles.favoriteText,
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: (value) async {
                query = value;
              },
              onSubmitted: (value) async {
                await loadRecipes();
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
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredRecipes.isEmpty
                ? Center(child: Text("No s'han trobat receptes"))
                : RecipeGrid(
                    filteredRecipes: filteredRecipes,
                    favorites: widget.favorites,
                    onFavoritePressed: widget.onFavoritePressed,
                  ),
          ),
        ],
      ),
    );
  }

  void showFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          children: [
            AppStyles.mediumSeparator,
            Text("Sel·lecciona una categoria", style: AppStyles.cardTitle),

            FutureBuilder<List<Category>>(
              future: categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("No s'han pogut carregar les categories"),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                final categories = snapshot.data!;
                if (categories.isEmpty) {
                  return Text("No hi ha categories");
                }
                return Wrap(
                  children: [
                    for (final category in categories)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ChoiceChip(
                          selected: selectedCategory == category,
                          onSelected: (isSelected) async {
                            selectedCategory = isSelected ? category : null;
                            Navigator.pop(context);
                            await loadRecipes();
                            setState(() {});
                          },
                          label: Text(category.name),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeGrid extends StatelessWidget {
  const RecipeGrid({
    super.key,
    required this.filteredRecipes,
    required this.favorites,
    required this.onFavoritePressed,
  });

  final List<Recipe> filteredRecipes;
  final Set<Recipe> favorites;
  final Function(Recipe recipe) onFavoritePressed;

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
          isFavorite: favorites.contains(recipe),
          onFavoritePressed: () => onFavoritePressed(recipe),
          onTap: () {
            openRecipe(context, recipe);
          },
        );
      },
    );
  }
}
