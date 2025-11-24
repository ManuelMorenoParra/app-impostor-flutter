import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'reveal_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Elegir modo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Jugador'),
              subtitle: const Text('Todos ven el mismo jugador excepto el impostor'),
              leading: const Icon(Icons.person),
              selected: gc.mode == GameMode.jugador,
              onTap: () => gc.setMode(GameMode.jugador),
            ),
            ListTile(
              title: const Text('Club'),
              subtitle: const Text('Modo club compartido'),
              leading: const Icon(Icons.sports_soccer),
              selected: gc.mode == GameMode.club,
              onTap: () => gc.setMode(GameMode.club),
            ),
            ListTile(
              title: const Text('Balón de Oro'),
              subtitle: const Text('Año o título del Balón de Oro'),
              leading: const Icon(Icons.emoji_events),
              selected: gc.mode == GameMode.balonoro,
              onTap: () => gc.setMode(GameMode.balonoro),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                gc.assignRoles();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RevealScreen()),
                );
              },
              child: const Text('Comenzar partida'),
            )
          ],
        ),
      ),
    );
  }
}
