import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receptari/screens/about_screen.dart';
import 'package:receptari/screens/splash_screen.dart';
import 'package:receptari/styles/app_styles.dart';

class AppDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      child: ListView(
        padding: .zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppStyles.primary),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text("Receptari", style: AppStyles.mainTitle),
                Text(user?.email ?? "---", style: AppStyles.statusText),
              ],
            ),
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
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Tancar sessió"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
