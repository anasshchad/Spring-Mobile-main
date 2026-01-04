import 'package:flutter/material.dart';
import 'pages/comptes_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Comptes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFFAFAFA),
      ),
      home: ComptesPage(), // Main page with list of comptes
    );
  }
}
