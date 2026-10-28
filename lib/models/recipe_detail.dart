// To parse this JSON data, do
//
//     final recipeDetail = recipeDetailFromJson(jsonString);

import 'dart:convert';

import 'package:receptari/models/ingredient.dart';

RecipeDetail recipeDetailFromJson(String str) =>
    RecipeDetail.fromJson(json.decode(str));

String recipeDetailToJson(RecipeDetail data) => json.encode(data.toJson());

class RecipeDetail {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final int minutes;
  final int servings;
  final List<Ingredient> ingredients;
  final List<String> steps;

  RecipeDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.minutes,
    required this.servings,
    required this.ingredients,
    required this.steps,
  });

  factory RecipeDetail.fromJson(Map<String, dynamic> json) => RecipeDetail(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    category: json["category"],
    minutes: json["minutes"],
    servings: json["servings"],
    ingredients: List<Ingredient>.from(
      json["ingredients"].map((x) => Ingredient.fromJson(x)),
    ),
    steps: List<String>.from(json["steps"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "imageUrl": imageUrl,
    "category": category,
    "minutes": minutes,
    "servings": servings,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
    "steps": List<dynamic>.from(steps.map((x) => x)),
  };
}
