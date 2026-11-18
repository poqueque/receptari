import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:receptari/models/recipe.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<Recipe> favorites = {};
  final box = Hive.box('favorites');

  void init() {
    for (final json in box.values) {
      favorites.add(Recipe.fromJson(Map<String, dynamic>.from(json)));
    }
  }

  void add(Recipe recipe) {
    favorites.add(recipe);
    box.put(recipe.id, recipe.toJson());
    notifyListeners();
  }

  void remove(Recipe recipe) {
    favorites.remove(recipe);
    box.delete(recipe.id);
    notifyListeners();
  }

  void clear() {
    favorites.clear();
    box.clear();
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
