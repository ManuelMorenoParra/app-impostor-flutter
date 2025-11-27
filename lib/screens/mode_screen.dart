import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'difficulty_screen.dart';
import 'assign_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    const purple = Color(0xFF8A2BE2);

    void startGame() {
      gc.assignRoles();
      Navigator.push(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const AssignScreen(), transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child)));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Elegir modo'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _optionTile(context, 'Jugador', 'Adivinar al jugador', Icons.person, gc.mode == GameMode.jugador, () => gc.setMode(GameMode.jugador)),
            const SizedBox(height: 10),
            _optionTile(context, 'Palabras', 'Modo palabras aleatorias', Icons.shield, gc.mode == GameMode.words, () => gc.setMode(GameMode.words)),
            const SizedBox(height: 10),
            _optionTile(context, 'Balón de Oro', 'Año del Balón de Oro', Icons.emoji_events, gc.mode == GameMode.balonoro, () => gc.setMode(GameMode.balonoro)),
            const SizedBox(height: 10),
            _optionTile(context, 'Clubes', 'Modo clubes de fútbol', Icons.sports_soccer, gc.mode == GameMode.club, () => gc.setMode(GameMode.club)),
            const SizedBox(height: 10),
            _optionTile(context, 'Selecciones', 'Modo de selecciones', Icons.flag, gc.mode == GameMode.seleccion, () => gc.setMode(GameMode.seleccion)),
            const Spacer(),
            if (gc.mode == GameMode.jugador) ...[
              Row(
                children: [
                  Expanded(child: _difficultyButton(context, 'Fácil', gc.difficulty == Difficulty.easy, () => gc.setDifficulty(Difficulty.easy))),
                  const SizedBox(width: 8),
                  Expanded(child: _difficultyButton(context, 'Media', gc.difficulty == Difficulty.medium, () => gc.setDifficulty(Difficulty.medium))),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _difficultyButton(context, 'Difícil', gc.difficulty == Difficulty.hard, () => gc.setDifficulty(Difficulty.hard))),
                  const SizedBox(width: 8),
                  Expanded(child: _difficultyButton(context, 'Todos', gc.difficulty == Difficulty.all, () => gc.setDifficulty(Difficulty.all))),
                ],
              ),
            ],
            const SizedBox(height: 18),
            ElevatedButton(onPressed: startGame, child: const Text('Comenzar partida')),
          ],
        ),
      ),
    );
  }

  Widget _optionTile(BuildContext ctx, String title, String subtitle, IconData icon, bool selected, VoidCallback onTap) {
    const purple = Color(0xFF8A2BE2);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? purple.withOpacity(0.18) : const Color(0xFF1A152E),
          borderRadius: BorderRadius.circular(14),
          border: selected ? Border.all(color: purple, width: 1.6) : null,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFFC6C1D9))),
          trailing: Icon(selected ? Icons.check_circle : Icons.chevron_right, color: selected ? purple : Colors.white54),
        ),
      ),
    );
  }

  Widget _difficultyButton(BuildContext ctx, String label, bool selected, VoidCallback onTap) {
    const purple = Color(0xFF8A2BE2);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? purple : const Color(0xFF241836),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(child: Text(label, style: TextStyle(color: selected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
