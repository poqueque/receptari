import 'package:flutter/material.dart';
import 'package:receptari/screens/about_screen.dart';
import 'package:receptari/styles/app_styles.dart';

class AppDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: .zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppStyles.primary),
            child: Text("Receptari", style: AppStyles.mainTitle),
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("Sobre el receptari"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
