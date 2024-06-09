import 'package:flutter/material.dart';
import 'package:tarea_flutter/ScoreRecordTableView.dart';

class ScoreRecordScreen extends StatelessWidget {
  const ScoreRecordScreen({super.key});

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Todos los resultados:'), 
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop(); 
        },
      ),
    ),
    body: const Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Center(
        child: ScoreRecordTableView(),
      ),
    ),
  );
}


}