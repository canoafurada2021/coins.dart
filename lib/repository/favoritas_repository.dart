import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/models_coins.dart';
import '../pages/moeda_hive_adapter.dart';


class FavoritasRepository extends ChangeNotifier{
 List<Moeda> _lista = [];

 late LazyBox box;

 FavoritasRepository(){
   _startRepository();
 }
 _startRepository() async{
   await _openBox();
   await _readFavoritas();
 }
 _openBox() async{
   Hive.registerAdapter(MoedaHiveAdapter());
   box = await Hive.openLazyBox<Moeda>('moedas-favoritas');
 }

 _readFavoritas()  {
   box.keys.forEach((moeda) async {
Moeda m = await box.get(moeda);
_lista.add(m);
notifyListeners();

   });
 }
 UnmodifiableListView<Moeda> get list => UnmodifiableListView(_lista);

 saveAll(List<Moeda> moedas) {
   moedas.forEach((moeda) {
     if(! _lista.any((atual) => atual.sigla == moeda.sigla)){
     _lista.add(moeda);
     box.put(moeda.sigla, moeda);
     }
   });
   notifyListeners();
 }

 remove(Moeda moeda) {
   _lista.remove(moeda);
   box.delete(moeda.sigla);
   notifyListeners();
 }
}