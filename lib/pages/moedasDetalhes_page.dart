import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/models_coins.dart';

class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;

  MoedasDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  _MoedasDetalhesPageState createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;

  comprar() async{
   if(_form.currentState!.validate()) {
     //Salvar
     
     Navigator.pop(context);
     
     ScaffoldMessenger.of(context).showSnackBar(
       const SnackBar(content: Text("Compra realizada com sucesso!")),
     
     );
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(widget.moeda.iconss),
                    width: 50,
                  ),
                  Container(width: 10),
                  Text(
                    real.format(widget.moeda.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  )
                ],
              ),
            ),
            (quantidade> 0)
            ? SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Text(
                    "$quantidade ${widget.moeda.sigla}",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
                margin:  const EdgeInsets.only(bottom: 24),
               // padding: EdgeInsets.all(24),
                alignment: Alignment.center,
                // decoration: BoxDecoration(
                //   color: Colors.teal.withOpacity(0.5),
                // ),
            ),
    )
            : Container(
              margin: const EdgeInsets.only(bottom: 24),
            ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: const TextStyle(fontSize: 22),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Valor',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  suffix: Text(
                    'reais',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o valor da compra';
                  } else if (double.parse(value) < 50) {
                    return 'Compra mínima de R\$ 50,00 ';
                  }
                  return null;
                },
             onChanged: (value){
              setState(() {
               quantidade = (value.isEmpty)
               ? 0
               : double.parse(value) / widget.moeda.preco;
              });
             },
              ),
            ),
            Container(
            alignment: Alignment.bottomCenter,
              margin: const  EdgeInsets.only(top:24),
            child: ElevatedButton(
             onPressed: comprar,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: const [
                Icon(Icons.check),
                 Padding(padding: EdgeInsets.all(16),
                child: Text(
                  'Comprar',
                style: TextStyle(fontSize: 20),
                ),
                 ),
               ],
             ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
