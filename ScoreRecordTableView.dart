import 'package:flutter/material.dart';
import 'package:tarea_flutter/ApiCalls.dart';
import 'package:tarea_flutter/Game.dart';

class ScoreRecordTableView extends StatefulWidget {
  const ScoreRecordTableView({super.key});

  @override
  ScoreRecordTableViewState createState() => ScoreRecordTableViewState();
}

List<Game> games = [];

class ScoreRecordTableViewState extends State<ScoreRecordTableView> {
  bool sortAscending = true;
  int sortColumnIndex = 0;
  
  @override
  void initState() {
    super.initState();
    updateGames();
  }

  void sortTable(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      games.sort((a, b) => ascending ? a.userName!.compareTo(b.userName!) : b.userName!.compareTo(a.userName!));
    } else if (columnIndex == 1) {
      games.sort((a, b) => ascending ? a.guesses!.compareTo(b.guesses!) : b.guesses!.compareTo(a.guesses!));
    } else if (columnIndex == 3) {
      games.sort((a, b) => ascending ? a.guesses!.compareTo(b.guesses!) : b.guesses!.compareTo(a.guesses!));
    } else if (columnIndex == 4) {
      games.sort((a, b) => ascending ? a.guesses!.compareTo(b.guesses!) : b.guesses!.compareTo(a.guesses!));
    }

    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
    });
  }

  void updateGames() async {
    bool thereIsNewData = await ApiCalls.getGames();
    if (thereIsNewData) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Table(
          border: TableBorder.all(),
          columnWidths: const {
            0: FlexColumnWidth(),
            1: FlexColumnWidth(),
            2: FlexColumnWidth(),
            3: FlexColumnWidth(),
            4: FlexColumnWidth(), 
          },
          children: [
            TableRow(
              children: [
                Center(
                  child: InkWell(
                    onTap: () => sortTable(0, !sortAscending),
                    child: const Text('Puntuación total', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () => sortTable(1, !sortAscending),
                    child: const Text('Nombre de usuario', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                Center(
                  child: InkWell(
                    onTap: () => sortTable(2, !sortAscending),
                    child: const Text('Aciertos', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
          

            for (var game in games)
              TableRow(
                children: [
                  Center(child: Text(game.getTotalScore().toStringAsFixed(2))),
                  Center(child: Text(game.userName!)),
                  Center(child: Text(game.guesses!.toString())),
                  
                ],
              ),
        ),
  }
}
