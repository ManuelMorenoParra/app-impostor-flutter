import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Impostor Fútbol",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // -------------------------------
            // MODO DE JUEGO
            // -------------------------------
            const Text(
              "Modo de juego",
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                _ModeCard(
                  title: "Jugador",
                  icon: Icons.person,
                  selected: game.mode == GameMode.jugador,
                  onTap: () => game.setMode(GameMode.jugador),
                ),
                const SizedBox(width: 10),
                _ModeCard(
                  title: "Palabras",
                  icon: Icons.shield,
                  selected: game.mode == GameMode.words,
                  onTap: () => game.setMode(GameMode.words),
                ),
                const SizedBox(width: 10),
                _ModeCard(
                  title: "Balón de Oro",
                  icon: Icons.sports_soccer,
                  selected: game.mode == GameMode.balonoro,
                  onTap: () => game.setMode(GameMode.balonoro),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // -------------------------------
            // DIFICULTAD (solo si es modo jugador)
            // -------------------------------
            if (game.mode == GameMode.jugador) ...[
              const Text(
                "Dificultad",
                style: TextStyle(color: Colors.white70, fontSize: 18),
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DifficultyButton(
                    label: "Fácil",
                    selected: game.difficulty == Difficulty.easy,
                    onTap: () => game.setDifficulty(Difficulty.easy),
                  ),
                  _DifficultyButton(
                    label: "Media",
                    selected: game.difficulty == Difficulty.medium,
                    onTap: () => game.setDifficulty(Difficulty.medium),
                  ),
                  _DifficultyButton(
                    label: "Difícil",
                    selected: game.difficulty == Difficulty.hard,
                    onTap: () => game.setDifficulty(Difficulty.hard),
                  ),
                  _DifficultyButton(
                    label: "Mixto",
                    selected: game.difficulty == Difficulty.mixed,
                    onTap: () => game.setDifficulty(Difficulty.mixed),
                  ),
                  _DifficultyButton(
                    label: "Todos",
                    selected: game.difficulty == Difficulty.all,
                    onTap: () => game.setDifficulty(Difficulty.all),
                  ),
                ],
              ),
            ],

            const Spacer(),

            // -------------------------------
            // BOTÓN INICIAR PARTIDA
            // -------------------------------
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  // Ir a pantalla de selección de roles
                  Navigator.pushNamed(context, "/assign");
                },
                child: const Text(
                  "Comenzar partida",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

//
// ==========================================================
//                     WIDGEt: _ModeCard
// ==========================================================
//
class _ModeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 110,
          decoration: BoxDecoration(
            color: selected ? Colors.greenAccent[700] : Colors.grey[900],
            borderRadius: BorderRadius.circular(16),
            border: selected
                ? Border.all(color: Colors.white, width: 2)
                : Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 40,
                  color: selected ? Colors.black : Colors.white70),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.black : Colors.white70,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// ==========================================================
//                 WIDGET: _DifficultyButton
// ==========================================================
//
class _DifficultyButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _DifficultyButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.greenAccent[700] : Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected ? Colors.black : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
