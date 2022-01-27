import 'package:flutter/material.dart';                                           
import 'package:flutter_projects/repository/coins_repository.dart';               
import 'package:intl/intl.dart';                                                  
                                                                                  
import '../models/models_coins.dart';                                             
                                                                                  
class MoedasPage extends StatefulWidget {                                         
  const MoedasPage({Key? key}) : super(key: key);                                 
                                                                                  
  @override                                                                       
  State<MoedasPage> createState() => _MoedasPageState();                          
}                                                                                 
                                                                                  
class _MoedasPageState extends State<MoedasPage> {                                
  @override                                                                       
  Widget build(BuildContext context) {                                            
    final tabela = MoedaRepository.tabela;                                        
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');      
    List<Moeda> selecionadas = [];                                                
    return Scaffold(                                                              
        appBar: AppBar(                                                           
          title: const Text('Cripto Moedas'),                                     
          centerTitle: true,                                                      
        ),                                                                         
        body: ListView.separated(                                                 
          itemBuilder: (BuildContext context, int moeda) {                        
            return ListTile(                                                      
              shape: const RoundedRectangleBorder(                                
                borderRadius: BorderRadius.all(Radius.circular(12)),              
              ),                                                                   
              leading: SizedBox(                                                  
                child: Image.asset(tabela[moeda].iconss),                         
                width: 40,                                                        
              ),                                                                   
              title: Text(tabela[moeda].nome, style: const TextStyle(             
                fontSize: 17,                                                     
                fontWeight: FontWeight.w500,                                      
              ),),                                                                 
              trailing: Text(real.format(tabela[moeda].preco),                    
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
            );                                                                     
          },                                                                      
          padding: const EdgeInsets.all(16),                                      
          separatorBuilder: (_, ___) => Divider(),                                
          itemCount: tabela.length,                                               
        ));                                                                        
  }                                                                               
}                                                                                 
