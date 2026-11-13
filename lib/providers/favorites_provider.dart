import 'package:flutter/material.dart';
import 'package:receptari/models/recipe.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<Recipe> favorites = {};

  void add(Recipe recipe) {
    favorites.add(recipe);
    notifyListeners();
  }

  void remove(Recipe recipe) {
    favorites.remove(recipe);
    notifyListeners();
  }

  void clear() {
    favorites.clear();
    notifyListeners();
  }

  void toggleFavorite(Recipe recipe) {
    if (favorites.contains(recipe)) {
      remove(recipe);
    } else {
      add(recipe);
    }
  }
}
