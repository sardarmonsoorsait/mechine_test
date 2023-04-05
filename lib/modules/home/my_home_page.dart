import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mechine_test/modules/play_ground/play_ground.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final rowController = TextEditingController();
  final columnController = TextEditingController();

  final playTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Home')),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Enter The Number of Rows columns and The Alphabets',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: rowController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Rows'),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: columnController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Columns'),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.length >
                    int.parse(rowController.text) *
                        int.parse(columnController.text)) {
                 // print(value);
                  return 'Only Alphabet ${int.parse(rowController.text) * int.parse(columnController.text)} required now it is${value.length}';
                }
               // print(value);
              },
              controller: playTextController,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                  labelText: 'Alphabets'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (rowController.text.isNotEmpty &&
                    columnController.text.isNotEmpty &&
                    playTextController.text.isNotEmpty) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlayGround(
                            row: int.parse(rowController.text),
                            column: int.parse(columnController.text),
                            playText: playTextController.text,
                          )));
                } else {
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('please enter all three values')));
                }
              },
              child: const Text('Make Grid'))
        ],
      )),
    );
  }
}
