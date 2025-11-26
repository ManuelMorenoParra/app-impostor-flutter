import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/mode_screen.dart';
import 'package:impostor_futbol/screens/register_screen.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool showSecret = false;
  bool showImpostor = false;

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    const purple = Color(0xFF8A2BE2);

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado final'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Card(
              color: const Color(0xFF1A152E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text('Secreto de la ronda', style: TextStyle(color: Color(0xFFC6C1D9))),
                    const SizedBox(height: 8),
                    Text(showSecret ? gc.secret : 'Oculto', style: TextStyle(color: showSecret ? purple : Colors.white54, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () => setState(() => showSecret = !showSecret), child: Text(showSecret ? 'Ocultar' : 'Revelar')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Card(
              color: const Color(0xFF1A152E),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Text('Impostor', style: TextStyle(color: Color(0xFFC6C1D9))),
                    const SizedBox(height: 8),
                    Text(showImpostor ? gc.players[gc.impostorIndex].name : 'Oculto', style: TextStyle(color: showImpostor ? Colors.redAccent : Colors.white54, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ElevatedButton(onPressed: () => setState(() => showImpostor = !showImpostor), child: Text(showImpostor ? 'Ocultar' : 'Revelar')),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Solo reinicia el juego, pero mantiene los jugadores
                final gc = Provider.of<GameController>(context, listen: false);
                gc.resetGame(); // ← Creamos un método que solo reinicie roles, no jugadores

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const ModeScreen()),
                );
              },
              child: const Text('Nueva partida'),
            )
          ],    
        ),
      ),
    );
  }
}
