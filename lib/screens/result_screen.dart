import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado / Fin de ronda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Secreto de la ronda:',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  gc.secret,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Impostor:', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Text(gc.players[gc.impostorIndex].name, style: const TextStyle(fontSize: 18)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                gc.reset();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Reiniciar partida'),
            )
          ],
        ),
      ),
    );
  }
}
