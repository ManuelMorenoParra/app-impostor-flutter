import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _opacity = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 120), () => setState(() => _opacity = 1));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeController>(context);
    const purple = Color(0xFF8A2BE2);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración'), backgroundColor: Colors.transparent),
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _opacity,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A152E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: purple.withOpacity(0.06), blurRadius: 10)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.dark_mode, color: Colors.white),
                    const SizedBox(width: 12),
                    const Expanded(child: Text('Tema oscuro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                    Switch(value: theme.isDark, onChanged: (_) => theme.toggleTheme()),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFF1A152E), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: const [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 12),
                    Text('Versión: 1.0', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
