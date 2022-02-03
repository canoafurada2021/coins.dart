import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/models/historico.dart';
import 'package:flutter_projects/repository/coins_repository.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '../database/db.dart';
import '../models/Posicao.dart';
import '../models/models_coins.dart';

class ContaRepository extends ChangeNotifier {


  late Database db;
  List<Posicao> _carteira = [];
  List<Historico> _historico = [];
  double _saldo = 0;

  get saldo => _saldo;

  List<Posicao> get carteira => _carteira;

  List<Historico> get historico => _historico;

  ContaRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _getSaldo();
    await _getCarteira();
    await _getHistorico();
  }

  _getSaldo() async {
    db = await DB.instance.database;
    List conta = await db.query('conta', limit: 1);
    _saldo = conta.first['saldo'];
    notifyListeners();
  }

  setSaldo(double valor) async {
    db = await DB.instance.database;
    db.update('conta', {
      'saldo': valor,
    });
    _saldo = valor;
    notifyListeners();
  }

  _getCarteira() async {
    _carteira = [];
    List posicoes = await db.query('carteira');
    posicoes.forEach((posicao) {
      Moeda moeda =
          MoedaRepository.tabela.firstWhere((m) => m.sigla == posicao['sigla']);

      _carteira.add(Posicao(
        moeda: moeda,
        quantidade: double.parse(posicao['quantidade']),
      ));
    });
    notifyListeners();
  }

  comprar(Moeda moeda, double valor) async {
    final DateFormat dateFormat;

    DateTime data = DateTime.now();
    dateFormat = DateFormat('dd/MM/yyyy - hh:mm');

    db = await DB.instance.database;
    await db.transaction((txn) async {
// Verificar se a moeda foi comprada
      final posicaoMoeda = await txn.query(
        'carteira',
        where: 'sigla = ?',
        whereArgs: [moeda.sigla],
      );
      //se não tem moeda
      if (posicaoMoeda.isEmpty) {
        await txn.insert('carteira', {
          'sigla': moeda.sigla,
          'moeda': moeda.nome,
          'quantidade': (valor / moeda.preco).toString(),
          'dataoperacao': dateFormat.format(data),
        });
      } //ja tem a moeda
      else {
        final atual = double.parse(posicaoMoeda.first['quantidade'].toString());
        await txn.update(
          'carteira',
          {'quantidade': ((valor / moeda.preco) + atual).toString(),
            'dataoperacao': dateFormat.format(data) },
          where: 'sigla = ?',
          whereArgs: [moeda.sigla],

        );
      }

      //inserir compra no historico
      await txn.insert('historico', {
        'sigla': moeda.sigla,
        'moeda': moeda.nome,
        'quantidade': (valor / moeda.preco).toString(),
        'valor': valor,
        'tipo_operacao': 'compra',
        'data_operacao': dateFormat.format(data),
      });

      //atualizar saldo
      await txn.update('conta', {'saldo': saldo - valor});
    });
    await _initRepository();
    notifyListeners();
  }

  _getHistorico() async {
    _historico = [];
    List operacoes = await db.query('historico');
    operacoes.forEach((operacao) {
      print(operacao);
      Moeda moeda = MoedaRepository.tabela
          .firstWhere((m) => m.sigla == operacao['sigla']);

      _historico.add(Historico(
          dataOperacao: DateFormat('dd/MM/yyyy').parse(operacao['data_operacao']),
          tipoOperacao: operacao['tipo_operacao'],
          moeda: moeda,
          valor: operacao['valor'],
          quantidade: double.parse(operacao['quantidade']),
        ),
      );
    });
    notifyListeners();
  }
}
