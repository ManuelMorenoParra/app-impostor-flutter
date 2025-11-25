import 'dart:math';
import 'package:flutter/foundation.dart';

// DATOS
import 'package:impostor_futbol/data/balon_oro_list.dart';
import 'package:impostor_futbol/data/words_list.dart';

// Nuevos datos por dificultad
import 'package:impostor_futbol/data/players_easy.dart';
import 'package:impostor_futbol/data/players_medium.dart';
import 'package:impostor_futbol/data/players_hard.dart';
import 'package:impostor_futbol/data/players_mixed.dart';

import '../models/player.dart';

enum GameMode { jugador, club, balonoro, words }
enum Difficulty { easy, medium, hard, mixed, all }

class GameController extends ChangeNotifier {
  List<Player> players = [];
  GameMode mode = GameMode.jugador;
  Difficulty difficulty = Difficulty.easy;

  String secret = '';
  int impostorIndex = -1;

  final Random _rng = Random();

  // ------------------------------
  // BASIC SETTERS
  // ------------------------------
  void setPlayers(List<String> names) {
    players = names.map((n) => Player(name: n)).toList();
    notifyListeners();
  }

  void setMode(GameMode m) {
    mode = m;
    notifyListeners();
  }

  void setDifficulty(Difficulty d) {
    difficulty = d;
    notifyListeners();
  }

  // ------------------------------
  // POOL DE DATOS SEGÚN MODO + DIFICULTAD
  // ------------------------------
  List<String> _getPool() {
    switch (mode) {
      case GameMode.jugador:
        return _getPoolForPlayers();
      case GameMode.words:
        return wordsList;
      case GameMode.balonoro:
        return balonOroData;
      default:
        return [];
    }
  }

  List<String> _getPoolForPlayers() {
    switch (difficulty) {
      case Difficulty.easy:
        return playersEasy;
      case Difficulty.medium:
        return playersMedium;
      case Difficulty.hard:
        return playersHard;
      case Difficulty.mixed:
        return playersMixed;
      case Difficulty.all:
        return [
          ...playersEasy,
          ...playersMedium,
          ...playersHard,
        ];
    }
  }

  // ------------------------------
  // ASIGNAR ROLES
  // ------------------------------
  void assignRoles() {
    if (players.isEmpty) return;

    impostorIndex = _rng.nextInt(players.length);

    final pool = _getPool();
    secret = pool[_rng.nextInt(pool.length)];

    notifyListeners();
  }

  // ------------------------------
  // REVELAR INFORMACIÓN
  // ------------------------------
  String revealForIndex(int index) {
    if (index == impostorIndex) return '¡Eres el impostor!';
    return secret;
  }

  // ------------------------------
  // RESET TOTAL DEL JUEGO
  // ------------------------------
  void reset() {
    secret = '';
    impostorIndex = -1;
    players = [];
    notifyListeners();
  }
}
