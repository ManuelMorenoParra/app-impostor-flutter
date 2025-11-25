import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class RevealScreen extends StatefulWidget {
  final int playerIndex;

  const RevealScreen({super.key, required this.playerIndex});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameController>();

    final playerName = game.players[widget.playerIndex].name;
    final revealText = game.revealForIndex(widget.playerIndex);

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Turno de $playerName"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: revealed ? Colors.greenAccent : Colors.white30,
                    width: 2,
                  ),
                ),
                width: double.infinity,
                height: 180,
                child: Center(
                  child: revealed
                      ? Text(
                          revealText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        )
                      : const Text(
                          "Oculto",
                          style: TextStyle(
                              color: Colors.white54,
                              fontSize: 22,
                              fontStyle: FontStyle.italic),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: () {
                  setState(() => revealed = !revealed);
                },
                child: Text(
                  revealed ? "Ocultar" : "Revelar",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: const Size(double.infinity, 55),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Siguiente jugador",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
