import 'package:flutter/material.dart';
import 'package:habittracker/pages/homepage.dart';
import 'package:habittracker/themes/themesupplier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeSupplier(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeSupplier>(context).themeData,
      home: HomePage(),
    );
  }
}
