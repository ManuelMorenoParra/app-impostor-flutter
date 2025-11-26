import 'package:flutter/material.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _slide = 20;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _opacity = 1.0;
        _slide = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reglas del Juego"),
        backgroundColor: const Color(0xFF0A144A),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0A144A),
              Color(0xFF0F2763),
              Color(0xFF144A7A),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 700),
          child: AnimatedSlide(
            offset: Offset(0, _slide / 100),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _ruleCard(
                      icon: Icons.people,
                      title: "1. Preparación",
                      description:
                          "Cada jugador introduce su nombre. Uno será elegido como impostor al azar.",
                    ),
                    const SizedBox(height: 16),
                    _ruleCard(
                      icon: Icons.visibility,
                      title: "2. Revelación",
                      description:
                          "Por turnos, los jugadores presionan su botón para descubrir si ven la palabra/secreto o si son el impostor.",
                    ),
                    const SizedBox(height: 16),
                    _ruleCard(
                      icon: Icons.question_answer,
                      title: "3. Debate",
                      description:
                          "Cuando todos han visto su rol, empieza un debate donde todos intentan adivinar quién es el impostor.",
                    ),
                    const SizedBox(height: 16),
                    _ruleCard(
                      icon: Icons.search,
                      title: "4. Objetivo",
                      description:
                          "• Los jugadores NO impostores deben descubrir quién no conoce la palabra.\n\n"
                          "• El impostor debe mezclarse y tratar de adivinar la palabra sin ser descubierto.",
                    ),
                    const SizedBox(height: 16),
                    _ruleCard(
                      icon: Icons.warning_amber_rounded,
                      title: "5. Final de la ronda",
                      description:
                          "Tras votación o acuerdo, se revela al impostor y el secreto mostrado.",
                    ),
                    const SizedBox(height: 40),

                    const Text(
                      "¡Diviértete maricon!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ruleCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black87, size: 30),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
