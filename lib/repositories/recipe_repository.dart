import 'package:receptari/models/category.dart';
import 'package:receptari/models/recipe.dart';
import 'package:receptari/models/recipe_detail.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes(String query, String? category);
  Future<List<Category>> getCategories();
  Future<RecipeDetail> getRecipe(int i);
}
