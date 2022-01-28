import 'package:flutter/material.dart';
import 'package:flutter_projects/pages/MoedasPage.dart';
import 'package:flutter_projects/repository/favoritas_repository.dart';
import 'package:flutter_projects/widget/moeda_card.dart';
import 'package:provider/provider.dart';


class FavoritasPage extends StatefulWidget {
  FavoritasPage({Key? key}) : super(key: key);

  @override
  _FavoritasPageState createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Moedas Favoritas'),
      ),
      body: Container(
        color:Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child: Consumer<FavoritasRepository>(
          builder: (context, favoritas, child) {
            return favoritas.list.isEmpty
                ? const ListTile(
              leading: Icon(Icons.star),
              title: Text("Ainda não ha moedas favoritas"),
            )
                : ListView.builder(
                itemCount: favoritas.list.length, itemBuilder: (_, index) {
              return MoedaCard(moeda: favoritas.list[index]);
            }
            );
          }
         )
      ),
    );
  }
}
