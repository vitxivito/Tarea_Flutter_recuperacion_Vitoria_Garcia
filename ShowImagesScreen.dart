import 'package:tarea_flutter/Navigation.dart';
import 'package:tarea_flutter/SettingsScreen.dart';
import 'package:tarea_flutter/ChooseImagesScreen.dart';
import 'package:flutter/material.dart';

final List<AssetImage> images = [
  const AssetImage('assets/images/caballo.jpeg'),
  const AssetImage('assets/images/cabra.jpeg'),
  const AssetImage('assets/images/cerdo.jpeg'),
  const AssetImage('assets/images/gato.jpeg'),
  const AssetImage('assets/images/pajarito.jpeg'),
  const AssetImage('assets/images/lobo.jpeg'),
  const AssetImage('assets/images/perro.jpeg'),
  const AssetImage('assets/images/oso.jpeg'),
  const AssetImage('assets/images/pollito.jpeg'),
  const AssetImage('assets/images/conejo.jpg'),
  const AssetImage('assets/images/zorro.jpeg'),
  const AssetImage('assets/images/vaca.jpg'),
];

class ShowImagesScreen extends StatefulWidget {
  const ShowImagesScreen({super.key});

  @override
  _ShowImagesScreenState createState() => _ShowImagesScreenState();
}

List<int> cardOrder = [];

class _ShowImagesScreenState extends State<ShowImagesScreen> {
  int _imageIndexToShow = 0;
  int numberOfCards = currentSettings?.numberOfCards ?? 0;
  Time time = Time();

  @override
  void initState() {
    super.initState();
    cardOrder = List<int>.generate(numberOfCards, (index) => index)..shuffle();
    time.startIntervalTimer(currentSettings?.cardTime ?? 0, _cambiarImagen);
  }

  void _cambiarImagen() {
    setState(() {
      if (_imageIndexToShow < numberOfCards - 1) {
        _imageIndexToShow++;
      } else {
        time.stopTimer();
        Navigation.replaceScreen(context, const ChooseImagesScreen());
      }
    });
  }

  @override
  void dispose() {
    time.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300, // Define el ancho fijo
          height: 300, // Define la altura fija
          decoration: BoxDecoration(
            image: DecorationImage(
              image: images[cardOrder[_imageIndexToShow]],
              fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
            ),
          ),
        ),
      ),
    );
  }

}
