import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:receptari/models/category.dart';
import 'package:receptari/models/category_list.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/models/recipe_list.dart';
import 'package:receptari/screens/recipe_detail_screen.dart';
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
  int selectedIndex = 0;
  List<Recipe> apiRecipes = [];
  bool isLoading = false;
  Category? selectedCategory;
  late Future<List<Category>> categoriesFuture;

  void toggleFavorite(Recipe recipe) {
    if (favorites.contains(recipe)) {
      favorites.remove(recipe);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Has tret ${recipe.title} de "
            "les favorites",
          ),
          persist: false,
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Desfer',
            onPressed: () {
              favorites.add(recipe);
              setState(() {});
            },
          ),
        ),
      );
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

  void openRecipe(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipeDetailScreen(recipe: recipe),
      ),
    );
  }

  Future<void> confirmClearFavorites() async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Treure de favorits"),
        content: Text("Segur que vols esborrar la recepta de favorits?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("CANCEL·LAR"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text("CONFIRMAR"),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      favorites.clear();
      setState(() {});
    }
    debugPrint("$confirmed");
  }

  Future<void> loadRecipes() async {
    isLoading = true;
    setState(() {});
    try {
      final http.Response response = await http.get(
        Uri.parse(
          "https://xupxup.poquesoft.net/recipes?search=$query&category=${selectedCategory?.id ?? ''}",
        ),
      );
      final RecipeList recipeList = recipeListFromJson(response.body);
      apiRecipes = recipeList.recipes;
    } catch (e) {
      if (!mounted) return;
      debugPrint(e.toString());
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
      final http.Response response = await http.get(
        Uri.parse("https://xupxup.poquesoft.net/categories"),
      );
      final categoryList = categoryListFromJson(response.body);
      return categoryList.categories;
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
    final List<Recipe> filteredRecipes = selectedIndex == 0
        ? apiRecipes.toList()
        : favorites.toList();

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
          if (selectedIndex == 1 && favorites.isNotEmpty)
            IconButton(
              onPressed: confirmClearFavorites,
              icon: Icon(Icons.delete),
            ),
        ],
      ),
      body: Column(
        children: [
          if (selectedIndex == 0)
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

          SizedBox(
            height: 48,
            child: FutureBuilder<List<Category>>(
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
                return ListView.builder(
                  scrollDirection: .horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ChoiceChip(
                        selected: selectedCategory == category,
                        onSelected: (isSelected) async {
                          if (isSelected) {
                            selectedCategory = category;
                          } else {
                            selectedCategory = null;
                          }
                          await loadRecipes();
                          setState(() {});
                        },
                        label: Text(categories[index].name),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredRecipes.isEmpty
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
                        onTap: () {
                          openRecipe(recipe);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          selectedIndex = value;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.restaurant), label: "Totes"),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
