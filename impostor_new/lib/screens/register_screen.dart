import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'mode_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _localPlayers = [];

  void _addPlayer() {
    final t = _controller.text.trim();
    if (t.isNotEmpty) {
      setState(() => _localPlayers.add(t));
      _controller.clear();
    }
  }

  void _goToMode() {
    if (_localPlayers.length < 3) return;
    final gc = Provider.of<GameController>(context, listen: false);
    gc.setPlayers(_localPlayers);
    Navigator.push(context, PageRouteBuilder(
      pageBuilder: (_, __, ___) => const ModeScreen(),
      transitionsBuilder: (_, anim, __, child) => FadeTransition(opacity: anim, child: child),
    ));
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8A2BE2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar jugadores'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A152E),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [BoxShadow(color: purple.withOpacity(0.12), blurRadius: 12)],
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Nombre del jugador',
                  hintStyle: TextStyle(color: Color(0xFFBFC0D9)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addPlayer,
                    child: const Text('Agregar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Align(alignment: Alignment.centerLeft, child: Text('Jugadores', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold))),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _localPlayers.length,
                itemBuilder: (_, i) {
                  final name = _localPlayers[i];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A152E),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: purple.withOpacity(0.06), blurRadius: 8)],
                    ),
                    child: ListTile(
                      title: Text(name, style: const TextStyle(color: Colors.white)),
                      trailing: IconButton(icon: const Icon(Icons.delete_outline, color: Colors.redAccent), onPressed: () => setState(() => _localPlayers.removeAt(i))),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _localPlayers.length >= 3 ? _goToMode : null,
              child: const Text('Siguiente: seleccionar modo'),
            ),
          ],
        ),
      ),
    );
  }
}
