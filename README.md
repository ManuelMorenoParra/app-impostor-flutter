# Proyecto: Impostor Fútbol (Flutter)

Este documento contiene **todo el proyecto listo para copiar/pegar** en un nuevo proyecto Flutter. Sigue las instrucciones al final para ejecutar.

---

## Estructura de archivos (usa exactamente estos paths dentro de `lib/`)

```
pubspec.yaml
lib/
  main.dart
  models/
    player.dart
  controllers/
    game_controller.dart
  data/
    players_data.dart
    clubs_data.dart
    balonoro_data.dart
  screens/
    register_screen.dart
    mode_screen.dart
    reveal_screen.dart
    result_screen.dart
  widgets/
    player_chip.dart
README.md
```

---

### FILE: pubspec.yaml
```yaml
name: impostor_futbol
description: Juego tipo impostor adaptado a fútbol (Jugador / Club / Balón de Oro)
publish_to: 'none'
version: 0.0.1
environment:
  sdk: '>=2.18.0 <3.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  cupertino_icons: ^1.0.2

flutter:
  uses-material-design: true
```

---

### FILE: lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/game_controller.dart';
import 'screens/register_screen.dart';

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
```

---

### FILE: lib/models/player.dart
```dart
class Player {
  final String name;
  Player({required this.name});
}
```

---

### FILE: lib/controllers/game_controller.dart
```dart
import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/player.dart';
import '../data/players_data.dart';
import '../data/clubs_data.dart';
import '../data/balonoro_data.dart';

enum GameMode { jugador, club, balonoro }

class GameController extends ChangeNotifier {
  List<Player> players = [];
  GameMode mode = GameMode.jugador;

  // palabra/elemento secreto que ven los no-impostores
  String secret = '';
  int impostorIndex = -1;

  final Random _rng = Random();

  void setPlayers(List<String> names) {
    players = names.map((n) => Player(name: n)).toList();
    notifyListeners();
  }

  void setMode(GameMode m) {
    mode = m;
    notifyListeners();
  }

  // Asigna secreto e impostor aleatorio
  void assignRoles() {
    if (players.isEmpty) return;

    impostorIndex = _rng.nextInt(players.length);

    switch (mode) {
      case GameMode.jugador:
        secret = playersData[_rng.nextInt(playersData.length)];
        break;
      case GameMode.club:
        secret = clubsData[_rng.nextInt(clubsData.length)];
        break;
      case GameMode.balonoro:
        secret = balonOroData[_rng.nextInt(balonOroData.length)];
        break;
    }
    notifyListeners();
  }

  String revealForIndex(int index) {
    if (index == impostorIndex) return '¡Eres el impostor!';
    return secret;
  }

  void reset() {
    secret = '';
    impostorIndex = -1;
    players = [];
    notifyListeners();
  }
}
```

---

### FILE: lib/data/players_data.dart
```dart
// Lista sencilla de jugadores (ejemplos) - añade más según quieras
const List<String> playersData = [
  'Lionel Messi',
  'Cristiano Ronaldo',
  'Neymar',
  'Kylian Mbappé',
  'Kevin De Bruyne',
  'Luka Modrić',
  'Robert Lewandowski',
  'Karim Benzema'
];
```

---

### FILE: lib/data/clubs_data.dart
```dart
const List<String> clubsData = [
  'FC Barcelona',
  'Real Madrid',
  'Manchester City',
  'Manchester United',
  'Paris Saint-Germain',
  'Bayern Munich',
  'Juventus',
  'AC Milan'
];
```

---

### FILE: lib/data/balonoro_data.dart
```dart
const List<String> balonOroData = [
  'Messi 2021',
  'Ronaldo 2008',
  'Modrić 2018',
  'Lewandowski 2020 (ficticio en lista)',
  'Benzema 2022'
];
```

---

### FILE: lib/screens/register_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'mode_screen.dart';
import '../widgets/player_chip.dart';

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
```

---

### FILE: lib/screens/mode_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'reveal_screen.dart';

class ModeScreen extends StatelessWidget {
  const ModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Elegir modo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Jugador'),
              subtitle: const Text('Todos ven el mismo jugador excepto el impostor'),
              leading: const Icon(Icons.person),
              selected: gc.mode == GameMode.jugador,
              onTap: () => gc.setMode(GameMode.jugador),
            ),
            ListTile(
              title: const Text('Club'),
              subtitle: const Text('Modo club compartido'),
              leading: const Icon(Icons.sports_soccer),
              selected: gc.mode == GameMode.club,
              onTap: () => gc.setMode(GameMode.club),
            ),
            ListTile(
              title: const Text('Balón de Oro'),
              subtitle: const Text('Año o título del Balón de Oro'),
              leading: const Icon(Icons.emoji_events),
              selected: gc.mode == GameMode.balonoro,
              onTap: () => gc.setMode(GameMode.balonoro),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                gc.assignRoles();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RevealScreen()),
                );
              },
              child: const Text('Comenzar partida'),
            )
          ],
        ),
      ),
    );
  }
}
```

---

### FILE: lib/screens/reveal_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';
import 'result_screen.dart';

class RevealScreen extends StatefulWidget {
  const RevealScreen({super.key});

  @override
  State<RevealScreen> createState() => _RevealScreenState();
}

class _RevealScreenState extends State<RevealScreen> {
  int _currentIndex = 0;
  bool _revealed = false;

  void _reveal(GameController gc) {
    setState(() => _revealed = true);
    // pequeño delay para que el jugador vea el rol y luego pueda pasar
    Future.delayed(const Duration(milliseconds: 600));
  }

  void _next(GameController gc) {
    setState(() {
      _revealed = false;
      _currentIndex++;
    });
    if (_currentIndex >= gc.players.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResultScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    final playerName = gc.players[_currentIndex].name;
    final revealText = gc.revealForIndex(_currentIndex);

    return Scaffold(
      appBar: AppBar(title: Text('Turno: ${playerName}')),
      body: GestureDetector(
        onVerticalDragEnd: (_) {
          if (!_revealed) _reveal(gc);
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Desliza hacia arriba para ver tu rol', style: Theme.of(context).textTheme.subtitle1),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black.withOpacity(0.1))],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: Center(
                      child: _revealed
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(revealText, textAlign: TextAlign.center, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                if (gc.impostorIndex == _currentIndex)
                                  const Text('Manténlo secreto!', style: TextStyle(fontStyle: FontStyle.italic)),
                                const SizedBox(height: 16),
                                ElevatedButton(onPressed: () => _next(gc), child: const Text('Siguiente'))
                              ],
                            )
                          : const Icon(Icons.touch_app, size: 64),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Jugador ${_currentIndex + 1} de ${gc.players.length}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

### FILE: lib/screens/result_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/game_controller.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gc = Provider.of<GameController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado / Fin de ronda')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Secreto de la ronda:', style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(gc.secret, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),
            Text('Impostor:', style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(gc.players[gc.impostorIndex].name, style: const TextStyle(fontSize: 18)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // reiniciar: vuelve a la pantalla de registro limpiando jugadores
                gc.reset();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Reiniciar partida'),
            )
          ],
        ),
      ),
    );
  }
}
```

---

### FILE: lib/widgets/player_chip.dart
```dart
import 'package:flutter/material.dart';

class PlayerChip extends StatelessWidget {
  final String name;
  final VoidCallback? onDelete;
  const PlayerChip({super.key, required this.name, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(name),
      onDeleted: onDelete,
    );
  }
}
```

---

### FILE: README.md
```md
# Impostor Fútbol (Flutter)

Proyecto mínimo funcional que implementa las mecánicas básicas descritas: registro de jugadores, selección de modo (Jugador/Club/Balón de Oro), asignación aleatoria del impostor y revelado por swipe.

## Cómo usar
1. Crea un nuevo proyecto Flutter (`flutter create impostor_futbol`) o borra la carpeta `lib/` y `pubspec.yaml` y pega los archivos de este repositorio.
2. Ejecuta `flutter pub get`.
3. Corre con `flutter run`.

## Notas
- Este proyecto es intencionalmente sencillo para que puedas ampliarlo: añadir temporizadores, votaciones, pistas, más datos, equipos por rondas, persistencia local, red para juego remoto, etc.
- Mejora UX: animaciones, protecciones para que no se vea la pantalla (cambia el brillo, añade bloqueo temporal), y pantalla de votación.
```

---

## Instrucciones finales (qué tienes que hacer ahora)

1. Abre este documento y copia cada archivo en tu proyecto Flutter (respectando rutas).
2. En terminal, dentro de la carpeta del proyecto ejecuta:

```bash
flutter pub get
flutter run
```

3. Si quieres que te entregue el proyecto comprimido o un APK listo, dímelo y lo preparo.

---

¡Listo! El proyecto completo está aquí. Si quieres que lo adapte (mejorar UI, añadir votación, temporizador, red/local multiplayer, sonido, o exportar APK) dime qué funcionalidad añado y lo hago.
