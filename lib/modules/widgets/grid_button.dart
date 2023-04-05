import 'package:flutter/material.dart';

import 'package:mechine_test/modules/widgets/enum.dart';

class GridButton extends StatelessWidget {
  const GridButton({super.key, required this.char, required this.changeButton,required this.newValue});
  final String char;
  final ChangeButton changeButton;
  final String newValue;

  @override
  Widget build(BuildContext context) {
    // print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\');
    // print(changeButton);
    // print('\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\');

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: changeButton == ChangeButton.none
                ? BorderRadius.circular(10)
                : changeButton == ChangeButton.contain&&newValue.contains(char)
                    ? BorderRadius.circular(50)
                    :changeButton==ChangeButton.notContain&&newValue.contains(char)? BorderRadius.circular(25):BorderRadius.circular(10),
            color: changeButton == ChangeButton.none
                ? Colors.blue
                : changeButton == ChangeButton.contain&&newValue.contains(char)
                    ? Colors.green
                    :changeButton==ChangeButton.notContain&&newValue.contains(char)? Colors.red:Colors.blue),
        child: Center(
            child: Text(
          char,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        )),
      ),
    );
  }
}
