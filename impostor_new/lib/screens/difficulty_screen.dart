import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';

class DifficultyScreen extends StatelessWidget {
  final Function(Difficulty difficulty) onSelect;
  const DifficultyScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8A2BE2);
    return Scaffold(
      appBar: AppBar(title: const Text("Elige dificultad"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            _buildButton(context, "Fácil", Difficulty.easy),
            const SizedBox(height: 12),
            _buildButton(context, "Medio", Difficulty.medium),
            const SizedBox(height: 12),
            _buildButton(context, "Difícil", Difficulty.hard),
            const SizedBox(height: 12),
            _buildButton(context, "Todos", Difficulty.all),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext ctx, String label, Difficulty value) {
    return ElevatedButton(
      onPressed: () => onSelect(value),
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(54)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
