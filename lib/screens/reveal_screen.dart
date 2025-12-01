import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'result_screen.dart';

class RevealFlowScreen extends StatefulWidget {
  const RevealFlowScreen({super.key});

  @override
  State<RevealFlowScreen> createState() => _RevealFlowScreenState();
}

class _RevealFlowScreenState extends State<RevealFlowScreen> {
  int index = 0;
  bool revealed = false;

  @override
  Widget build(BuildContext context) {
    final gc = context.watch<GameController>();
    const purple = Color(0xFF8A2BE2);

    final player = gc.players[index].name;
    final text = gc.revealForIndex(index);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // NOMBRE DEL JUGADOR
              Text(
                "Jugador ${index + 1}/${gc.players.length}",
                style: const TextStyle(color: Colors.white54, fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                player,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 35),

              // TARJETA REVELADA / OCULTA
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A152E),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: revealed ? purple : purple.withOpacity(0.15),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: revealed ? purple.withOpacity(0.5) : Colors.transparent,
                    ),
                  ],
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  child: revealed
                      ? Column(
                          key: ValueKey("revealed_$index"), // ✔ key única por jugador
                          children: [
                            Text(
                              text,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (gc.impostorIndex == index)
                              const Text(
                                "¡Eres el impostor!",
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                ),
                              ),
                          ],
                        )
                      : Icon(
                          Icons.lock,
                          key: ValueKey("hidden_$index"),
                          size: 80,
                          color: Colors.white30,
                        ),
                ),
              ),

              const SizedBox(height: 40),

              // BOTÓN
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    // Mostrar rol
                    if (!revealed) {
                      setState(() => revealed = true);
                      return;
                    }

                    // Siguiente jugador
                    if (index + 1 >= gc.players.length) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResultScreen(),
                        ),
                      );
                    } else {
                      setState(() {
                        index++;
                        revealed = false;
                      });
                    }
                  },
                  child: Text(
                    revealed ? "Siguiente jugador" : "Revelar",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
