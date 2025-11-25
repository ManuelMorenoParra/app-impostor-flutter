import 'package:flutter/material.dart';

class DifficultyScreen extends StatelessWidget {
  final Function(String difficulty) onSelect;

  const DifficultyScreen({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Elige dificultad")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildButton(context, "Fácil", "easy"),
            const SizedBox(height: 16),
            _buildButton(context, "Medio", "medium"),
            const SizedBox(height: 16),
            _buildButton(context, "Difícil", "hard"),
            const SizedBox(height: 16),
            _buildButton(context, "Libre (mezclado)", "mixed"),
            const SizedBox(height: 16),
            _buildButton(context, "Todos ", "all"),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext ctx, String label, String value) {
    return ElevatedButton(
      onPressed: () => onSelect(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(label, style: const TextStyle(fontSize: 20)),
      ),
    );
  }
}
