import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:receptari/providers/favorites_provider.dart';
import 'package:receptari/screens/home_screen.dart';
import 'package:receptari/services/preferences.dart';
import 'package:receptari/styles/app_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String status = "Arrencant aplicació";

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 8,
          children: [
            Icon(Icons.soup_kitchen, size: 128, color: AppStyles.onPrimary),
            Text("Receptari", style: AppStyles.mainTitle),
            Text("1.0.0", style: AppStyles.smallWhiteText),
            AppStyles.bigSeparator,
            Text(status, style: AppStyles.mediumWhiteText),
          ],
        ),
      ),
    );
  }

  Future<void> init() async {
    await Preferences.instance.init();
    status = "Inicialitzant base de dades...";
    setState(() {});
    await Hive.initFlutter();
    await Hive.openBox('favorites');
    await Hive.openBox('cache');
    if (!mounted) return;
    status = "Carregant favorits...";
    setState(() {});
    context.read<FavoritesProvider>().init();
    status = "Carregant més dades...";
    setState(() {});
    await Future.delayed(Duration(seconds: 1));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
