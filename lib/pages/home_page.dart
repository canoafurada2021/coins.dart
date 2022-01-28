import 'package:flutter/material.dart';
import 'package:flutter_projects/pages/MoedasPage.dart';
import 'package:flutter_projects/pages/configuracoes_page.dart';

import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
     paginaAtual = pagina;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: [
          const MoedasPage(),
          FavoritasPage(),
          const ConfiguracoesPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todas'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
        onTap: (pagina) {
          pc.animateToPage(
            pagina,
            duration: const Duration(microseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
