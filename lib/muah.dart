import 'package:flutter/material.dart';

void main() => runApp(Muah());

class Muah extends StatelessWidget {
  const Muah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
       extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('App Bar'),
          centerTitle: true,
          leading: BackButton(),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const Drawer(),
        body: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops:[0.5, 1],
                  colors: [Colors.black87, Colors.purple])
            ),
            child: Center(
              child: const Text('Hello World'),
            ),
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
              icon: Icon(Icons.star),
              label: 'item 2',
            ),
          ],
        ),
    ),

    );

  }
}
