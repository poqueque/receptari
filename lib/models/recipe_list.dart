// To parse this JSON data, do
//
//     final recipeList = recipeListFromJson(jsonString);

import 'dart:convert';

import 'package:receptari/models/recipe.dart';

RecipeList recipeListFromJson(String str) =>
    RecipeList.fromJson(json.decode(str));

String recipeListToJson(RecipeList data) => json.encode(data.toJson());

class RecipeList {
  final List<Recipe> recipes;

  RecipeList({required this.recipes});

  factory RecipeList.fromJson(Map<String, dynamic> json) => RecipeList(
    recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
  };
}
