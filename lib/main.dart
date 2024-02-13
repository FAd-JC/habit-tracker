import 'package:flutter/material.dart';
import 'package:habittracker/database/habitdatabase.dart';
import 'package:habittracker/pages/homepage.dart';
import 'package:habittracker/themes/themesupplier.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Habit Database
  await HabitDataBase.initialize();

  // Save the first launch date
  await HabitDataBase().saveFirstLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        // Provide the Habit Database as a ChangeNotifier
        ChangeNotifierProvider(
          create: (context) => HabitDataBase(),
        ),
        // Provide the Theme Supplier as a ChangeNotifier
        ChangeNotifierProvider(
          create: (context) => ThemeSupplier(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Use the theme from the ThemeSupplier
      theme: Provider.of<ThemeSupplier>(context).themeData,
      home: HomePage(),
    );
  }
}
