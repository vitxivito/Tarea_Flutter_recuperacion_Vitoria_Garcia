import 'package:flutter/material.dart';
import 'package:tarea_flutter/ChooseImagesScreen.dart';
import 'package:tarea_flutter/Navigation.dart';
import 'package:tarea_flutter/SaveLoad.dart';
import 'package:tarea_flutter/SettingsScreen.dart';
import 'package:tarea_flutter/ShowImagesScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  currentSettings = await SaveLoad.loadSettings();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( 
          title: const Text('Inicio'),
        ),
        body: Builder( // Usar un Builder para obtener el contexto correcto
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigation.replaceScreen(context, const SettingsScreen()), 
                    child: const Text('Ajustes')
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      resetGame();
                      Navigation.replaceScreen(context, const ShowImagesScreen());
                    }, 
                    child: const Text('Jugar')
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void resetGame() {
    userOrder.clear();
    cardOrder.clear();
    time = Time();
  }
}

