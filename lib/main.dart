import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:receptari/screens/recipe_list_screen.dart';
import 'package:receptari/styles/app_styles.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: GoogleFonts.lexend().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: AppStyles.primary,
          foregroundColor: AppStyles.onPrimary,
        ),
      ),
      home: RecipeListScreen(),
    );
  }
}
