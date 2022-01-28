import 'package:flutter/material.dart';
import 'package:flutter_projects/configs/app_settings.dart';
import 'package:flutter_projects/repository/conta_repository.dart';
import 'package:flutter_projects/repository/favoritas_repository.dart';
import 'package:provider/provider.dart';
import '../configs/hive_config.dart';
import '../my_app.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await HiveConfig.start();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContaRepository(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppSettings(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoritasRepository(),
        ),
      ],
      child: Muah(),
    ),
  );
}
