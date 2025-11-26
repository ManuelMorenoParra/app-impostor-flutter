import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'reveal_screen.dart';
import 'difficulty_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);

    /// INICIA EL JUEGO → Asigna roles y comienza por el jugador 0
    void startGame() {
      gc.assignRoles();

      /// Revelación SIEMPRE debe empezar en el 0
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RevealScreen(playerIndex: 0),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Elegir modo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --------------------
            //   MODO JUGADOR
            // --------------------
            ListTile(
              title: const Text('Jugador'),
              subtitle: const Text('Todos ven el mismo jugador excepto el impostor'),
              leading: const Icon(Icons.person),
              selected: gc.mode == GameMode.jugador,
              onTap: () => gc.setMode(GameMode.jugador),
            ),

            // --------------------
            //   MODO PALABRAS
            // --------------------
            ListTile(
              title: const Text('Palabras'),
              subtitle: const Text('Modo palabras aleatorias'),
              leading: const Icon(Icons.shield),
              selected: gc.mode == GameMode.words,
              onTap: () => gc.setMode(GameMode.words),
            ),

            // --------------------
            //   MODO BALÓN DE ORO
            // --------------------
            ListTile(
              title: const Text('Balón de Oro'),
              subtitle: const Text('Año del Balón de Oro'),
              leading: const Icon(Icons.emoji_events),
              selected: gc.mode == GameMode.balonoro,
              onTap: () => gc.setMode(GameMode.balonoro),
            ),

            const Spacer(),

            // --------------------
            //     BOTÓN COMENZAR
            // --------------------
            ElevatedButton(
              onPressed: () {
                if (gc.mode == GameMode.jugador) {
                  // Primero elegir dificultad
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DifficultyScreen(
                        onSelect: (difficulty) {
                          gc.setDifficulty(difficulty);
                          Navigator.pop(context); // vuelve al menú
                          startGame(); // inicia juego
                        },
                      ),
                    ),
                  );
                } else {
                  // Otros modos no requieren dificultad
                  startGame();
                }
              },
              child: const Text('Comenzar partida'),
            ),
          ],
        ),
      ),
    );
  }
}
