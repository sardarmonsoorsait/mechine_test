import 'package:flutter/material.dart';
import 'package:mechine_test/modules/widgets/enum.dart';
import 'package:mechine_test/modules/widgets/grid_button.dart';

class PlayGround extends StatelessWidget {
  PlayGround(
      {super.key,
      required this.row,
      required this.column,
      required this.playText});
  final int row;
  final int column;
  final String playText;
  //String newText = '';
  ValueNotifier<String> newText = ValueNotifier('');

  ValueNotifier<bool> isAllDirection = ValueNotifier(false);
  List<GridButton> gridButtonList = [];
  TextEditingController playTextController = TextEditingController();
  ChangeButton changeButton = ChangeButton.none;
  String columnText = '';

  List<Widget> getGridButtons(
      String value, ChangeButton cngbtn, String newValue) {
    gridButtonList = [];
    value.runes.forEach((int rune) {
      var character = String.fromCharCode(rune);
      //print(cngbtn);
      gridButtonList.add(GridButton(
        char: character,
        changeButton: cngbtn,
        newValue: newValue,
      ));

      //print(character);
    });
    return gridButtonList;
  }

  onPlayTextChanged(String value) {
    List<String> rowList = [];
    List<String> columnList = [];
    for (var i = 0; i < playText.length; i += row) {
      rowList.add(playText.substring(
          i, i + row > playText.length ? playText.length : i + row));
    }

    for (var i = 0; i < rowList.first.length; i++) {
      columnText = '';
      for (var j = 0; j < rowList.length; j++) {
        columnText += rowList[j].substring(i, i + 1);
      }
      columnList.add(columnText);
    }

    rowList.addAll(columnList);
    List<String> demoRowList = [];
    String demoRow = '';
    if (isAllDirection.value) {
      print(rowList);
      for (var i = 0; i < rowList.length; i++) {
        demoRow = rowList[i].split('').reversed.join('');
        demoRowList.add(demoRow);
      }
      rowList.addAll(demoRowList);
    }
    print(rowList);

    for (var i = 0; i < rowList.length; i++) {
      if (rowList[i].contains(value)) {
        changeButton = ChangeButton.contain;
        newText.value = value;
        break;
      } else {
        changeButton = ChangeButton.notContain;
        newText.value = value;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Play Ground')),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: playTextController,
              onChanged: onPlayTextChanged,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Play Text'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.grid_4x4_outlined),
              Text('all direction'),
              ValueListenableBuilder(
                  valueListenable: isAllDirection,
                  builder: (ctx, direction, _) {
                    return Switch(
                        value: direction,
                        onChanged: (value) {
                          value == false
                              ? isAllDirection.value = false
                              : isAllDirection.value = true;
                        });
                  })
            ],
          ),
          ValueListenableBuilder(
              valueListenable: newText,
              builder: (context, newText, _) {
                return Expanded(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: row,
                    ),
                    children: getGridButtons(playText, changeButton, newText),
                  ),
                );
              })
        ],
      ),
    );
  }
}
