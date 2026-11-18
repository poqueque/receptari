import 'package:hive_ce/hive.dart';
import 'package:http/http.dart' as http;
import 'package:receptari/models/category.dart';
import 'package:receptari/models/category_list.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/models/recipe_detail.dart';
import 'package:receptari/models/recipe_list.dart';
import 'package:receptari/repositories/recipe_repository.dart';

class ApiRecipeRepository extends RecipeRepository {
  final baseUrl = 'https://xupxup.poquesoft.net';
  final cache = Hive.box('cache');

  Future<String> getBody(String path) async {
    try {
      final http.Response response = await http.get(
        Uri.parse('$baseUrl/$path'),
      );
      if (response.statusCode != 200) {
        throw Exception('Error ${response.statusCode}');
      }
      cache.put(path, response.body);
      return response.body;
    } catch (e) {
      final body = cache.get(path);
      if (body == null) {
        rethrow;
      }
      return body;
    }
  }

  @override
  Future<List<Recipe>> getRecipes(String query, String? category) async {
    final body = await getBody(
      'recipes?search=$query&category=${category ?? ""}',
    );
    return recipeListFromJson(body).recipes;
  }

  @override
  Future<List<Category>> getCategories() async {
    final body = await getBody('categories');
    return categoryListFromJson(body).categories;
  }

  @override
  Future<RecipeDetail> getRecipe(int i) async {
    final body = await getBody('recipes/$i');
    return recipeDetailFromJson(body);
  }
}
