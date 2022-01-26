

import 'package:flutter/material.dart';

void main() => runApp(Muah());

class Muah extends StatelessWidget {
  const Muah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Bar'),
        ),
        drawer: const Drawer(),
        body: Center(
          child: Container(
            child: const Text('Hello World'),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_rounded),
              label:'item 1',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.co2),
              label: 'item 2',
            ),
          ],
        ),
    ),
    );

  }
}
