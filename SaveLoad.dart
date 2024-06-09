import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarea_flutter/Game.dart';
import 'package:tarea_flutter/Settings.dart';
import 'dart:convert';

class SaveLoad {
  static Future<void> saveSettings(Settings settings) async {
  final prefs = await SharedPreferences.getInstance();
  String settingsJson = json.encode(settings.toJson());
  await prefs.setString('settings', settingsJson);
  }

  static Future<Settings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    String? settingsJson = prefs.getString('settings');
    if (settingsJson != null) {
      return Settings.fromJson(json.decode(settingsJson));
    } else {
      return Settings.empty(); 
    }
  }

  static Future<void> saveGame(Game game) async {
    final prefs = await SharedPreferences.getInstance();
    String gameJson = json.encode(game.toJson());
    await prefs.setString('game', gameJson);
  }

  static Future<Game?> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    String? gameJson = prefs.getString('game');
    if (gameJson != null) {
      return Game.fromJson(json.decode(gameJson));
    } else {
      return null;
    }
  }

  static Future<void> saveNum(String key, num value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else {
      throw Exception("El valor numérico no es ni int ni double");
    }
  }

  static Future<num?> loadNum(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      if (prefs.get(key) is int) {
        return prefs.getInt(key);
      } else if (prefs.get(key) is double) {
        return prefs.getDouble(key);
      }
    }
    return 0; // Devuelve 0 si la clave no existe
  }

  static Future<void> saveUserName(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> loadUserName(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
