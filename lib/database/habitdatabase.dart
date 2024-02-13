import 'package:flutter/material.dart';
import 'package:habittracker/models/app_preferences.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDataBase extends ChangeNotifier {
  static late Isar isar;
  static Future<void> initalize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([HabitSchema, AppPreferencesSchema],
        directory: dir.path);
  }
  //setup

  //initialize (for heatmap)
  //save first date  of app

  //get first date of app

//List of habits

//add new habit

//save habit from db

//update habit. change on/off
//update habit. change name
//delete habit
}
