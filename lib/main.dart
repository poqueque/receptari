import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/recipe.dart';
import 'screens/recipe_detail_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: GoogleFonts.lexend().fontFamily),
      home: RecipeDetailScreen(recipe: arrabiata),
    );
  }
}
