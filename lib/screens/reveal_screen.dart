import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'result_screen.dart';

class RevealScreen extends StatefulWidget {
  final int playerIndex;     // ← NECESARIO

  const RevealScreen({super.key, required this.playerIndex});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  late int _currentIndex;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.playerIndex; // ← SE USA EL ÍNDICE RECIBIDO
  }

  void _toggleReveal() {
    setState(() => _revealed = !_revealed);
  }

  void _next(GameController gc) {
    setState(() {
      _revealed = false;
      _currentIndex++;
    });

    // Si ya pasaron todos → pantalla final
    if (_currentIndex >= gc.players.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResultScreen()),
      );
      return;
    }

    // Avanza a la pantalla del siguiente jugador
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RevealScreen(playerIndex: _currentIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);

    // Previene errores si algo falla antes
    if (_currentIndex >= gc.players.length) {
      return const Scaffold(
        body: Center(child: Text("Error: índice fuera de rango")),
      );
    }

    final playerName = gc.players[_currentIndex].name;
    final revealText = gc.revealForIndex(_currentIndex);

    return Scaffold(
      appBar: AppBar(title: const Text('Revelación')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleReveal,
                child: Text(_revealed ? 'Ocultar' : 'Revelar'),
              ),
              const SizedBox(height: 20),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.12),
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Turno de: $playerName',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 160,
                      child: Center(
                        child: _revealed
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    revealText,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (gc.impostorIndex == _currentIndex)
                                    const Text(
                                      '¡Eres el impostor!',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                ],
                              )
                            : const Icon(Icons.lock, size: 64),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () => _next(gc),
                child: const Text('Siguiente jugador'),
              ),

              const SizedBox(height: 12),

              Text(
                'Jugador ${_currentIndex + 1} de ${gc.players.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
