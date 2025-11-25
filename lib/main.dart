import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Asegúrate de importar provider si lo usas

import 'controllers/game_controller.dart';
import 'screens/register_screen.dart'; // Si usas otras pantallas, importa sus archivos

void main() {
  runApp(const ImpostorFutbolApp());
}

class ImpostorFutbolApp extends StatelessWidget {
  const ImpostorFutbolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Impostor Fútbol',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const RegisterScreen(),
      ),
    );
  }
}
