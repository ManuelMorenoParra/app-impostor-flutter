import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'result_screen.dart';

class RevealScreen extends StatefulWidget {
  final int playerIndex;
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
    _currentIndex = widget.playerIndex;
  }

  void _toggleReveal() => setState(() => _revealed = !_revealed);

  void _next(BuildContext context) {
    final gc = Provider.of<GameController>(context, listen: false);
    setState(() => _revealed = false);
    final next = _currentIndex + 1;
    if (next >= gc.players.length) {
      Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => const ResultScreen(), transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child)));
      return;
    }
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (_, __, ___) => RevealScreen(playerIndex: next), transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child)));
  }

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    const purple = Color(0xFF8A2BE2);

    if (_currentIndex >= gc.players.length) {
      return Scaffold(body: Center(child: Text('Índice fuera de rango', style: TextStyle(color: Colors.white))));
    }

    final playerName = gc.players[_currentIndex].name;
    final revealText = gc.revealForIndex(_currentIndex);

    return Scaffold(
      appBar: AppBar(title: const Text('Revelación'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 6),
            AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF1A152E),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: purple.withOpacity(0.06), blurRadius: 12)],
              ),
              child: Column(
                children: [
                  Text('Turno de: $playerName', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 140,
                    child: Center(
                      child: _revealed
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(revealText, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                if (gc.impostorIndex == _currentIndex)
                                  const Text('¡Eres el impostor!', style: TextStyle(color: Colors.redAccent)),
                              ],
                            )
                          : Icon(Icons.lock, size: 64, color: purple.withOpacity(0.9)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: _toggleReveal, child: Text(_revealed ? 'Ocultar' : 'Revelar'))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton(onPressed: () => _next(context), child: const Text('Siguiente jugador'))),
              ],
            ),
            const SizedBox(height: 12),
            Text('Jugador ${_currentIndex + 1} de ${gc.players.length}', style: const TextStyle(color: Color(0xFFC6C1D9))),
          ],
        ),
      ),
    );
  }
}
