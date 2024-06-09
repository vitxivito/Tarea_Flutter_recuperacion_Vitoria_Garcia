// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tarea_flutter/ApiCalls.dart';
import 'package:tarea_flutter/Game.dart';
import 'package:tarea_flutter/GridViewBuilder.dart';
import 'package:tarea_flutter/SettingsScreen.dart';
import 'package:tarea_flutter/ShowImagesScreen.dart';
import 'package:tarea_flutter/Navigation.dart';
import 'package:tarea_flutter/YourScoreScreen.dart';

List<int> userOrder = [];
Time time = Time();

class ChooseImagesScreen extends StatefulWidget {
  const ChooseImagesScreen({super.key});

  @override
  ChooseImagesScreenState createState() => ChooseImagesScreenState();
}

class ChooseImagesScreenState extends State<ChooseImagesScreen> {
  @override
  void initState() {
    super.initState();
    time.timeLimit = currentSettings?.timeLimit ?? 60;
    time.startTimer(_updateTime);
  }

  void _updateTime() {
    if (mounted) {
      setState(() {});
    }

    if (time.progress >= 1) {
      time.stopTimer();
      Navigation.replaceScreen(context, const LostScreen());
    } 
  }

  bool triedAndFailed = false;

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    Color buttonColor = triedAndFailed ? const Color.fromARGB(255, 216, 80, 12) : const Color.fromARGB(255, 22, 141, 214);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 20, 
        ),
        child: SingleChildScrollView( 
          child: Column(
            children: [
              Container(
                color: Colors.blueGrey,
                height: screenHeight * 0.5, // Altura proporcional a la pantalla
                child: GridViewBuilder(
                  columns: 3,
                  spaceBetweenRows: 10,
                  spaceBetweenColumns: 10,
                  content: List.generate((currentSettings?.numberOfCards ?? 0), (index) => index),
                  onCellSelected: _updateGridView,
                  id: "first",
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.lightGreen,
                height: screenHeight * 0.10, // Altura proporcional a la pantalla
                child: GridViewBuilder(
                  columns: currentSettings?.numberOfCards ?? 0,
                  spaceBetweenRows: 10,
                  spaceBetweenColumns: 10,
                  content: userOrder,
                  onCellSelected: _updateGridView,
                  id: "second",
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.redAccent,
                height: screenHeight * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Text(
                      time.getParsedCurrentTime(),  
                      style: const TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white, 
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LinearProgressIndicator(
                        value: time.progress, 
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.blue, 
                        ),
                        minHeight: 10, 
                      ),
                    ),
                    const SizedBox(height: 20), 
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(buttonColor), 
                      ),
                      onPressed: () async {
                        setState(() {
                          if (userOrder.length != cardOrder.length) {
                            triedAndFailed = true;
                          } else {
                            ApiCalls.postGame(Game().getCurrentGame());
                            currentGame.resetGame();
                            Navigation.replaceScreen(context, const YourScoreScreen()); 
                            time.stopTimer();
                          }
                        });

                        await Time.waitForSeconds(2);

                        if (mounted) {
                          setState(() {
                            triedAndFailed = false;
                          });
                        }
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    time.stopTimer(); 
    super.dispose();
  }

  void _updateGridView(int index, String id) {
    setState(() {
      if (id == "first") {
        onImagesGridViewTapped(index);
      } else {
        userOrder.removeAt(index);
      }
    });
  }

  void onImagesGridViewTapped(int index) {
    if (!userOrder.contains(index)) {
      userOrder.add(index);
    }
  }
}
