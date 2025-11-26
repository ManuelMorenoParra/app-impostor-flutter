import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/result_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'reveal_screen.dart';

class AssignScreen extends StatelessWidget {
  const AssignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();
    const purple = Color(0xFF8A2BE2);

    return Scaffold(
      appBar: AppBar(title: const Text('Asignación de roles'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const Text('Toca tu nombre para revelar tu rol (pasa el móvil después).', style: TextStyle(color: Color(0xFFC6C1D9))),
            const SizedBox(height: 14),
            Expanded(
              child: ListView.builder(
                itemCount: game.players.length,
                itemBuilder: (context, i) {
                  final p = game.players[i];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A152E),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: purple.withOpacity(0.06)),
                    ),
                    child: ListTile(
                      title: Text(p.name, style: const TextStyle(color: Colors.white)),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                      onTap: () {
                        Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (_, __, ___) => RevealScreen(playerIndex: i),
                          transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
                        ));
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResultScreen()),
                );
              },
              child: const Text('Ir al resultado'),
            )
          ],
        ),
      ),
    );
  }
}
