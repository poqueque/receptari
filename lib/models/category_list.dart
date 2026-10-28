// To parse this JSON data, do
//
//     final categoryList = categoryListFromJson(jsonString);

import 'dart:convert';

import 'package:receptari/models/category.dart';

CategoryList categoryListFromJson(String str) =>
    CategoryList.fromJson(json.decode(str));

String categoryListToJson(CategoryList data) => json.encode(data.toJson());

class CategoryList {
  final List<Category> categories;

  CategoryList({required this.categories});

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    categories: List<Category>.from(
      json["categories"].map((x) => Category.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}
