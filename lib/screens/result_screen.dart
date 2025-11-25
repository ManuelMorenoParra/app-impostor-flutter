import 'package:flutter/material.dart';
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
    final game = context.watch<GameController>();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Resultado final"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            //
            // SECRET
            //
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Secreto de la ronda",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      showSecret ? game.secret : "Oculto",
                      style: TextStyle(
                        color: showSecret ? Colors.greenAccent : Colors.white30,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => showSecret = !showSecret),
                      child: Text(showSecret ? "Ocultar" : "Revelar"),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            //
            // IMPOSTOR
            //
            Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "El impostor era",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      showImpostor
                          ? game.players[game.impostorIndex].name
                          : "Oculto",
                      style: TextStyle(
                        color:
                            showImpostor ? Colors.redAccent : Colors.white30,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => showImpostor = !showImpostor),
                      child: Text(showImpostor ? "Ocultar" : "Revelar"),
                    )
                  ],
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent[700],
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () {
                game.reset();
                Navigator.popUntil(context, (r) => r.isFirst);
              },
              child: const Text(
                "Nueva partida",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
