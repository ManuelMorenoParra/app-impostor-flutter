import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'controllers/theme_controller.dart';
import 'screens/main_menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => GameController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Paleta morado neon
  static const bg = Color(0xFF0D0B1E);
  static const purple = Color(0xFF8A2BE2);
  static const purpleAccent = Color(0xFFB56CFF);
  static const card = Color(0xFF1A152E);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);

    final base = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      colorScheme: const ColorScheme.dark(
        primary: purple,
        secondary: purpleAccent,
      ),
      cardColor: card,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: Color(0xFFC6C1D9)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: purple,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          elevation: 8,
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Impostor Fútbol',
      themeMode: theme.themeMode,
      theme: base,
      darkTheme: base,
      home: const MainMenu(),
      // rutas rápidas si las usas
      routes: {
        '/main': (_) => const MainMenu(),
      },
    );
  }
}
