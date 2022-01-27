import '../models/models_coins.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
     Moeda(
      nome: "bitcoin",
      iconss: 'lib/images/bitcoin.png',
      sigla: "BTC",
      preco: 164603.00
  ),

  Moeda(
  iconss: 'lib/images/etherum 2.png',
  nome: "Etherum",
  sigla: "ETH2",
  preco: 13068.77
  ),
    Moeda(
        iconss: 'lib/images/polkadot.png',
        nome: "polkadot",
        sigla: "DOT",
        preco: 95.92
    ),
    Moeda(
        iconss: 'lib/images/USD.png',
        nome: "USD Coin",
        sigla: "USDC",
        preco: 5.42
    ),
    Moeda(
        iconss: 'lib/images/XRP.png',
        nome: "XRP",
        sigla: "XRP",
        preco: 3.31
    ),
  ];
}
