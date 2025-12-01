import 'package:flutter/material.dart';
import 'package:impostor_futbol/screens/mode_screen.dart';
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
    const purple = Color(0xFF9F5BFF);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Resultado Final',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1D0A34),
              Color(0xFF0F0A1F),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 80),

              // ----------- CARD DE SECRETO -----------
              _buildRevealCard(
                title: "Secreto de la ronda",
                revealedText: gc.secret,
                isShown: showSecret,
                onPressed: () => setState(() => showSecret = !showSecret),
                color: purple,
              ),

              const SizedBox(height: 18),

              // ----------- CARD DE IMPOSTOR -----------
              _buildRevealCard(
                title: "Impostor",
                revealedText: gc.players[gc.impostorIndex].name,
                isShown: showImpostor,
                onPressed: () => setState(() => showImpostor = !showImpostor),
                color: Colors.redAccent,
              ),

              const Spacer(),

              // ----------- BOTÓN NUEVA PARTIDA -----------
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: purple,
                    elevation: 5,
                  ),
                  onPressed: () {
                    final gc = Provider.of<GameController>(context, listen: false);
                    gc.resetGame();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const ModeScreen()),
                    );
                  },
                  child: const Text(
                    'Nueva partida',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRevealCard({
    required String title,
    required String revealedText,
    required bool isShown,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Card(
      color: const Color(0xFF22183C),
      elevation: 8,
      shadowColor: Colors.black45,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: Color(0xFFE0DAF5),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),

            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isShown ? color : Colors.white30,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              child: Text(isShown ? revealedText : "Oculto"),
            ),

            const SizedBox(height: 14),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B2A66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
              ),
              onPressed: onPressed,
              child: Text(
                isShown ? "Ocultar" : "Revelar",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
