import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});
  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  double _opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () => setState(() => _opacity = 1));
  }

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF8A2BE2);
    return Scaffold(
      appBar: AppBar(title: const Text('Reglas'), backgroundColor: Colors.transparent),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: _opacity,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
              _card('Preparación', 'Introduce los nombres. Mínimo 3 jugadores. Se asigna un impostor al azar.'),
              _card('Revelación', 'Cada jugador, por turno, revela su rol (revelar/ocultar). No mires el teléfono del vecino.'),
              _card('Debate', 'Tras la ronda se debate y se vota al sospechoso.'),
              _card('Objetivo', 'Los no-impostores descubren la palabra; el impostor intenta adivinarla.'),
              const SizedBox(height: 20),
              Center(child: Text('¡Diviértete mariconazo!', style: TextStyle(color: purple, fontSize: 20, fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card(String title, String body) {
    const purple = Color(0xFF8A2BE2);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A152E),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: purple.withOpacity(0.06), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(color: Color(0xFFC6C1D9))),
        ],
      ),
    );
  }
}
