import 'package:flutter/material.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/screens/favorites_screen.dart';
import 'package:receptari/screens/recipe_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final Set<Recipe> favorites = {};

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

  @override
  Widget build(BuildContext context) {
    final screens = [
      RecipeListScreen(onFavoritePressed: toggleFavorite, favorites: favorites),
      FavoritesScreen(
        favorites: favorites,
        onFavoritePressed: toggleFavorite,
        onClearFavorites: confirmClearFavorites,
      ),
    ];
    return PopScope(
      canPop: selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          selectedIndex = 0;
          setState(() {});
        }
      },
      child: Scaffold(
        body: IndexedStack(index: selectedIndex, children: screens),
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
      ),
    );
  }
}
