import 'package:flutter/material.dart';
import 'package:flutter_projects/pages/home_page.dart';
import 'pages/MoedasPage.dart';

class Muah extends StatelessWidget {
  const Muah({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
title: 'Moedasbase',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
    primarySwatch: Colors.indigo,
    ),
    home: HomePage(),
    );
  }
}