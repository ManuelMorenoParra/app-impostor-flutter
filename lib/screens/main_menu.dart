import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/register_screen.dart';
import 'mode_screen.dart';
import 'rules_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {
  double _titleOpacity = 0;
  double _buttonsOpacity = 0;
  double _logoScale = 0.5;
  double _titleSlide = 30;

  @override
  void initState() {
    super.initState();

    // Animación secuencial
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _logoScale = 1.0);
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() => _titleOpacity = 1.0);
      _titleSlide = 0;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      setState(() => _buttonsOpacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A144A),
              Color(0xFF0F2763),
              Color(0xFF144A7A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // LOGO ANIMADO
              AnimatedScale(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutBack,
                scale: _logoScale,
                child: const Icon(
                  Icons.visibility,
                  color: Colors.white,
                  size: 100,
                ),
              ),
              const SizedBox(height: 20),

              // TÍTULO ANIMADO
              AnimatedOpacity(
                opacity: _titleOpacity,
                duration: const Duration(milliseconds: 600),
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 600),
                  offset: Offset(0, _titleSlide / 100),
                  curve: Curves.easeOut,
                  child: const Text(
                    "IMPOSTOR DE FÚTBOL klk",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // BOTONES ANIMADOS
              AnimatedOpacity(
                opacity: _buttonsOpacity,
                duration: const Duration(milliseconds: 700),
                child: Column(
                  children: [
                    _menuButton(
                      text: "Jugar",
                      icon: Icons.play_arrow,
                      onTap: () => _goTo(const RegisterScreen()),
                    ),
                    const SizedBox(height: 20),
                    _menuButton(
                      text: "Reglas",
                      icon: Icons.menu_book,
                      onTap: () => _goTo(const RulesScreen()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // Versión abajo
              Text(
                "v1.0",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuButton({required String text, required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.92),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 26, color: Colors.black87),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goTo(Widget page) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, anim, __) => FadeTransition(opacity: anim, child: page),
      ),
    );
  }
}
