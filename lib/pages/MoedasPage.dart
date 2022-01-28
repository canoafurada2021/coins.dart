import 'package:flutter/material.dart';
import 'package:flutter_projects/pages/moedasDetalhes_page.dart';
import 'package:flutter_projects/repository/coins_repository.dart';
import 'package:flutter_projects/repository/favoritas_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../configs/app_settings.dart';
import '../models/models_coins.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  final tabela = MoedaRepository.tabela;
  late NumberFormat real;
  late Map<String, String> loc;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
        icon: const Icon(Icons.language),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.swap_vert),
                  title: Text('Usar $locale'),
                  onTap: () {
                    context.read<AppSettings>().setLocale(locale, name);
                    Navigator.pop(context);
                  },
                ),
              )
            ]
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        centerTitle: true,
        title: const Text("CriptoMoedas"),
        actions: [
          changeLanguageButton(),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
              limparSelecionadas();
            },
        ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MoedasDetalhesPage(moeda: moeda)),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();
    readNumberFormat();
    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            leading: (selecionadas.contains(tabela[moeda]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[moeda].iconss),
                    width: 40,
                  ),
            title: Row(
              children: [
                Text(
                  tabela[moeda].nome,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.list.any((fav) => fav.sigla == tabela[moeda].sigla))
                  const Icon(Icons.circle, color: Colors.amber, size: 8),
              ],
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                (selecionadas.contains(tabela[moeda]))
                    ? selecionadas.remove(tabela[moeda])
                    : selecionadas.add(tabela[moeda]);
              });
            },
            onTap: () => mostrarDetalhes(tabela[moeda]),
          );
        },
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, ___) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas;
              },
              icon: const Icon(Icons.star),
              label: const Text(
                'FAVORITAR',
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
