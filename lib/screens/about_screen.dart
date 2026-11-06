import 'package:flutter/material.dart';
import 'package:receptari/styles/app_styles.dart';

class AboutScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sobre el receptari")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Receptari", style: AppStyles.sectionTitle),
            AppStyles.smallSeparator,
            Text("Versió 1.0.0"),
            AppStyles.mediumSeparator,
            Text("Les receptes i les fotos son de la XupXupAPI"),
          ],
        ),
      ),
    );
  }
}
