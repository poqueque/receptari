import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:receptari/models/category.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/providers/favorites_provider.dart';
import 'package:receptari/repositories/api_recipe_repository.dart';
import 'package:receptari/repositories/recipe_repository.dart';
import 'package:receptari/styles/app_styles.dart';
import 'package:receptari/widgets/app_drawer.dart';
import 'package:receptari/widgets/recipe_grid.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

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
      apiRecipes = await recipeRepository.getRecipes(
        query,
        selectedCategory?.id,
      );
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
    final favorites = context.watch<FavoritesProvider>().favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Receptari"),
        actions: [
          IconButton(
            tooltip: "Filtrar per categoria",
            onPressed: showFilters,
            icon: Badge(
              backgroundColor: AppStyles.onPrimary,
              textColor: AppStyles.primary,
              isLabelVisible: selectedCategory != null,
              child: Icon(Icons.filter_list),
            ),
          ),
          Semantics(
            label: "Receptes favorites",
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                alignment: .center,
                children: [
                  Icon(Icons.favorite, size: 40),
                  Text(
                    '${favorites.length}',
                    style: AppStyles.favoriteText,
                    textScaler: MediaQuery.textScalerOf(context)
                        .clamp(maxScaleFactor: 1.3),
                  ),
                ],
              ),
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
                        tooltip: "Esborrar la cerca",
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
                : RecipeGrid(filteredRecipes: filteredRecipes),
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
