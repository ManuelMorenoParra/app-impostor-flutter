import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:impostor_futbol/data/balon_oro_list.dart';
import 'package:impostor_futbol/data/clubs_list.dart';
import 'package:impostor_futbol/data/players_list.dart';
import '../models/player.dart';

enum GameMode { jugador, club, balonoro }

class GameController extends ChangeNotifier {
  List<Player> players = [];
  GameMode mode = GameMode.jugador;

  // Palabra/elemento secreto que ven los no-impostores
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
