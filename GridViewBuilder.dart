import 'package:flutter/material.dart';
import 'package:tarea_flutter/ChooseImagesScreen.dart';
import 'package:tarea_flutter/ShowImagesScreen.dart';

class GridViewBuilder extends StatefulWidget {
  final int columns;
  final double spaceBetweenRows;
  final double spaceBetweenColumns;
  final List<int> content;
  final Function(int index, String id) onCellSelected;
  final String id;

  const GridViewBuilder({super.key, 
    required this.columns,
    required this.spaceBetweenRows,
    required this.spaceBetweenColumns,
    required this.content,
    required this.onCellSelected,
    required this.id,
  });

  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.columns,
        crossAxisSpacing: widget.spaceBetweenRows,
        mainAxisSpacing: widget.spaceBetweenColumns,
      ),
      itemCount: widget.content.length,
      itemBuilder: (context, index) {
        return buildCell(index);
      },
    );
  }

  Widget buildCell(int index) {
    bool isSelected = userOrder.contains(index);
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onCellSelected(index, widget.id);
        });
      },
      child: Container(
        child: Opacity(
          opacity: determineOpacity(isSelected, widget.id),
          child: Image(
            image: images[widget.content[index]],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  double determineOpacity(bool isSelected, String id) {
    if (id == "first") {
      return isSelected ? 0.5 : 1.0;
    }
    return 1.0;
  }
}


  
