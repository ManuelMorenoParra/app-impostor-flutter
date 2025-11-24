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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ModeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar jugadores')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Nombre del jugador',
                suffixIcon: Icon(Icons.person_add),
              ),
              onSubmitted: (_) => _addPlayer(),
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _addPlayer, child: const Text('Agregar')),
            const SizedBox(height: 16),
            const Text('Jugadores:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _localPlayers.length,
                itemBuilder: (_, i) => ListTile(
                  title: Text(_localPlayers[i]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => setState(() => _localPlayers.removeAt(i)),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _localPlayers.length >= 3 ? _goToMode : null,
              child: const Text('Siguiente: seleccionar modo'),
            )
          ],
        ),
      ),
    );
  }
}
