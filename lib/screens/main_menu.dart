import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/register_screen.dart';
import 'mode_screen.dart';
import 'rules_screen.dart';
import 'settings_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {
  double _logoScale = 0.7;
  double _titleOpacity = 0;
  double _buttonsOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () => setState(() => _logoScale = 1.0));
    Future.delayed(const Duration(milliseconds: 380), () => setState(() => _titleOpacity = 1.0));
    Future.delayed(const Duration(milliseconds: 720), () => setState(() => _buttonsOpacity = 1.0));
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8A2BE2);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D0B1E), Color(0xFF140A33)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  duration: const Duration(milliseconds: 700),
                  scale: _logoScale,
                  curve: Curves.elasticOut,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: purple.withOpacity(0.08),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: purple.withOpacity(0.18), blurRadius: 24)],
                    ),
                    child: const Icon(Icons.sports_soccer, color: Colors.white, size: 68),
                  ),
                ),
                const SizedBox(height: 18),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _titleOpacity,
                  child: const Text(
                    'IMPOSTOR',
                    style: TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: 4),
                  ),
                ),
                const SizedBox(height: 36),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _buttonsOpacity,
                  child: Column(
                    children: [
                      _menuButton('Jugar', Icons.play_arrow, () => _push(const RegisterScreen())),
                      const SizedBox(height: 14),
                      _menuButton('Reglas', Icons.menu_book, () => _push(const RulesScreen())),
                      const SizedBox(height: 14),
                      _menuButton('Configuración', Icons.settings, () => _push(const SettingsScreen())),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text('v1.0', style: TextStyle(color: Colors.white.withOpacity(0.45))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String label, IconData icon, VoidCallback onTap) {
    const purple = Color(0xFF8A2BE2);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: purple.withOpacity(0.12)),
          boxShadow: [BoxShadow(color: purple.withOpacity(0.08), blurRadius: 10)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _push(Widget page) {
    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 420),
      pageBuilder: (_, anim, __) => FadeTransition(opacity: anim, child: page),
    ));
  }
}
