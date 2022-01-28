import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class AppSettings extends ChangeNotifier{
  late Box box;
  // late SharedPreferences _prefs;
  Map<String, String> locale = {
    'locale': 'pt_BR',
    'name': 'R\$',
  };

  AppSettings() {
    _startSettings();
  }
  _startSettings() async{
    await _StartPreferences();
    await _readLocale();
  }
  
  Future<void>_StartPreferences() async{
    // _prefs = await SharedPreferences.getInstance();
    box = await Hive.openBox('preferencias');

  }
  _readLocale() {
    final local = box.get('local') ?? 'pt_BR';
    final name = box.get('name') ?? 'R\$';
    locale = {
      'locale': local,
      'name': name,
    };
    notifyListeners();
  }
  setLocale(String local, String name) async{
    await box.put('local', local);
    await box.put('name', name);
    await _readLocale();
  }
}