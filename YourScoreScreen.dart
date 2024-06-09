import 'package:flutter/material.dart';
import 'package:tarea_flutter/ChooseImagesScreen.dart';
import 'package:tarea_flutter/Game.dart';
import 'package:tarea_flutter/Navigation.dart';
import 'package:tarea_flutter/ScoreRecordScreen.dart';
import 'package:tarea_flutter/ShowImagesScreen.dart';

final Game currentGame = Game().getCurrentGame();

class YourScoreScreen extends StatelessWidget {
  const YourScoreScreen({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cellWidth = screenWidth * 0.2;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Estos han sido tus resultados:",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "El orden correcto era:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ), 
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), // Márgenes izquierda y derecha
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userOrder.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: cellWidth,
                    child: Image(
                      image: images[cardOrder[index]],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          const Text(
            "El orden que has elegido es:",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15), // Márgenes izquierda y derecha
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: cardOrder.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: cellWidth,
                    child: Image(
                      image: images[userOrder[index]],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
            Text("Nombre de usuario: ${currentGame.userName}"),
            Text("Fecha de la partida: ${currentGame.datePlayed}"),
            Text("Aciertos: ${currentGame.guesses}"),
            Text("Duración de la partida: ${currentGame.timePlayed}"),
            ElevatedButton(
              onPressed: () {
                Navigation.replaceScreen(context, const ScoreRecordScreen());
              },
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ),
    );
  }
}
