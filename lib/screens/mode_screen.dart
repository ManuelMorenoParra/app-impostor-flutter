import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/reveal_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  static const Color purple = Color(0xFF8A2BE2);

  @override
  Widget build(BuildContext context) {
    final gc = context.watch<GameController>();

    void startGame() {
      gc.assignRoles();

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const RevealFlowScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A152E),
      appBar: AppBar(
        title: const Text('Elegir modo'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _optionTile(
              'Jugador',
              'Adivinar al jugador',
              Icons.person,
              gc.mode == GameMode.jugador,
              () => gc.setMode(GameMode.jugador),
            ),
            const SizedBox(height: 10),
            _optionTile(
              'Palabras',
              'Modo palabras aleatorias',
              Icons.shield,
              gc.mode == GameMode.words,
              () => gc.setMode(GameMode.words),
            ),
            const SizedBox(height: 10),
            _optionTile(
              'Balón de Oro',
              'Año del Balón de Oro',
              Icons.emoji_events,
              gc.mode == GameMode.balonoro,
              () => gc.setMode(GameMode.balonoro),
            ),
            const SizedBox(height: 10),
            _optionTile(
              'Clubes',
              'Modo clubes de fútbol',
              Icons.sports_soccer,
              gc.mode == GameMode.club,
              () => gc.setMode(GameMode.club),
            ),
            const SizedBox(height: 10),
            _optionTile(
              'Selecciones',
              'Modo selecciones',
              Icons.flag,
              gc.mode == GameMode.seleccion,
              () => gc.setMode(GameMode.seleccion),
            ),

            const Spacer(),

            if (gc.mode == GameMode.jugador) _difficultySelector(gc),

            const SizedBox(height: 18),

            ElevatedButton(
              onPressed: startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Comenzar partida',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------------
  // OPCIONES DEL MODO
  // ------------------------------------------------------------------------
  Widget _optionTile(
    String title,
    String subtitle,
    IconData icon,
    bool selected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? purple.withAlpha((0.18 * 255).round())
              : const Color(0xFF241836),
          borderRadius: BorderRadius.circular(14),
          border: selected ? Border.all(color: purple, width: 1.6) : null,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Color(0xFFC6C1D9)),
          ),
          trailing: Icon(
            selected ? Icons.check_circle : Icons.chevron_right,
            color: selected ? purple : Colors.white54,
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------------
  // SELECCIÓN DE DIFICULTAD
  // ------------------------------------------------------------------------
  Widget _difficultySelector(GameController gc) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _difficultyButton(
                'Fácil',
                gc.difficulty == Difficulty.easy,
                () => gc.setDifficulty(Difficulty.easy),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _difficultyButton(
                'Media',
                gc.difficulty == Difficulty.medium,
                () => gc.setDifficulty(Difficulty.medium),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _difficultyButton(
                'Difícil',
                gc.difficulty == Difficulty.hard,
                () => gc.setDifficulty(Difficulty.hard),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _difficultyButton(
                'Todos',
                gc.difficulty == Difficulty.all,
                () => gc.setDifficulty(Difficulty.all),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ------------------------------------------------------------------------
  // BOTÓN INDIVIDUAL DE DIFICULTAD
  // ------------------------------------------------------------------------
  Widget _difficultyButton(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? purple : const Color(0xFF241836),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
