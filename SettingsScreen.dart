import 'package:flutter/material.dart';

import 'package:tarea_flutter/Navigation.dart';
import 'package:tarea_flutter/SaveLoad.dart';
import 'package:tarea_flutter/Settings.dart';

Settings? currentSettings;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _textController = TextEditingController();

  int _timeLimitSegment = 0;
  int _numberOfCardsSegment = 0;
  int _cardTimeSegment = 0;

  final List<num> _timeLimits = [15, 30, 60];
  final List<num> _numberOfCards = [6, 9, 12];
  final List<num> _cardTimes = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.5;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajustes"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _saveSettingsAndReturn,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: containerWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Introduce tu nombre de usuario:"),
              TextField(controller: _textController),
              const SizedBox(height: 20),
              const Text("Elige la duración de la partida:"),
              _buildSegmentedControl(_timeLimits, _timeLimitSegment, (int newIndex) {
                setState(() => _timeLimitSegment = newIndex);
              }),
              const SizedBox(height: 20),
              const Text("Elige el número de imágenes:"),
              _buildSegmentedControl(_numberOfCards, _numberOfCardsSegment, (int newIndex) {
                setState(() => _numberOfCardsSegment = newIndex);
              }),
              const SizedBox(height: 20),
              const Text("Elige la velocidad de las imágenes:"),
              _buildSegmentedControl(_cardTimes, _cardTimeSegment, (int newIndex) {
                setState(() => _cardTimeSegment = newIndex);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSegmentedControl(List<num> options, int selectedIndex, ValueChanged<int> onIndexChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(options.length, (int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ChoiceChip(
            label: Text("${options[index]}"),
            selected: selectedIndex == index,
            onSelected: (_) => onIndexChanged(index),
          ),
        );
      }),
    );
  }

  void _saveSettingsAndReturn() async {
    currentSettings = Settings(
      userName: _textController.text,
      timeLimit: _timeLimits[_timeLimitSegment] as int,
      numberOfCards: _numberOfCards[_numberOfCardsSegment] as int,
      cardTime: _cardTimes[_cardTimeSegment] as int,
    );

    await SaveLoad.saveUserName("userName", _textController.text);
    await SaveLoad.saveNum("timeLimit", _timeLimitSegment);
    await SaveLoad.saveNum("numberOfCards", _numberOfCardsSegment);
    await SaveLoad.saveNum("cardTime", _cardTimeSegment);
    await SaveLoad.saveSettings(currentSettings!);

    Navigation.removeScreen(context);
  }

  void _loadSettings() async {
    String? userName = await SaveLoad.loadUserName("userName");
    _textController.text = userName ?? "";

    _timeLimitSegment = await SaveLoad.loadNum("timeLimit") as int;
    _numberOfCardsSegment = await SaveLoad.loadNum("numberOfCards") as int;
    _cardTimeSegment = await SaveLoad.loadNum("cardTime") as int;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

