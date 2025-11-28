import 'dart:math';
import 'package:flutter/foundation.dart';

// DATOS
import 'package:impostor_futbol/data/balon_oro_list.dart';
import 'package:impostor_futbol/data/words_list.dart';

// Nuevos datos por dificultad
import 'package:impostor_futbol/data/players_easy.dart';
import 'package:impostor_futbol/data/players_medium.dart';
import 'package:impostor_futbol/data/players_hard.dart';

// CLUBES
import 'package:impostor_futbol/data/clubs_mode.dart';
import 'package:impostor_futbol/data/selecciones_list.dart';

import '../models/player.dart';

enum GameMode { jugador, club, balonoro, words, seleccion }
enum Difficulty { easy, medium, hard, all }

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
  // POOL SEGÚN MODO + DIFICULTAD
  // ------------------------------
  List<String> _getPool() {
    switch (mode) {
      case GameMode.jugador:
        return _getPlayerPool();

      case GameMode.words:
        return wordsList;

      case GameMode.balonoro:
        return balonOroData;

      case GameMode.club:
        return clubsMode;

      case GameMode.seleccion:
        return seleccionList;

      default:
        return [];
    }
  }

  List<String> _getPlayerPool() {
    switch (difficulty) {
      case Difficulty.easy:
        return playersEasy;

      case Difficulty.medium:
        return playersMedium;

      case Difficulty.hard:
        return playersHard;

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

    if (pool.isEmpty) {
      secret = "ERROR: la base de datos está vacía";
    } else {
      secret = pool[_rng.nextInt(pool.length)];
    }

    notifyListeners();
  }

  // ------------------------------
  // REVELAR
  // ------------------------------
  String revealForIndex(int index) {
    if (index == impostorIndex) {
      return "❌ ¡Eres el IMPOSTOR!\n"
          "Tu objetivo: confundir sin que te pillen gillipollas.";
    }

    return "\n$secret";
  }

  // ------------------------------
  // RESET
  // ------------------------------
  void resetGame() {
    secret = '';
    impostorIndex = -1;
    notifyListeners();
  }
}
