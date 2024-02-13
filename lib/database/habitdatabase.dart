import 'package:flutter/material.dart';
import 'package:habittracker/models/app_preferences.dart';
import 'package:habittracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDataBase extends ChangeNotifier {
  // Initialize Isar (for the database)
  static late Isar isar;

  // Initialize Isar and set up directory for the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppPreferencesSchema],
      directory: dir.path,
    );
  }

  // Save the first launch date of the app
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appPreferences.where().findFirst();
    if (existingSettings == null) {
      final preferences = AppPreferences()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appPreferences.put(preferences));
    }
  }

  // Get the first launch date of the app
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appPreferences.where().findFirst();
    return settings?.firstLaunchDate;
  }

  // List of habits
  final List<Habit> currentHabits = [];

  // Add a new habit to the database
  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;

    await isar.writeTxn(() => isar.habits.put(newHabit));

    // Refresh the list of habits
    readHabits();
  }

  // Read habits from the database and update the list
  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    // Notify listeners to update the UI
    notifyListeners();
  }

  // Update habit's completion status (on/off)
  Future<void> updateHabitCheck(int id, bool isCheck) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        if (isCheck && !habit.daysCompleted.contains(DateTime.now())) {
          final today = DateTime.now();

          habit.daysCompleted.add(DateTime(
            today.year,
            today.month,
            today.day,
          ));
        }
        // Habit not completed
        else {
          habit.daysCompleted.removeWhere(
            (date) =>
                date.year == DateTime.now().year &&
                date.month == DateTime.now().month &&
                date.day == DateTime.now().day,
          );
        }
        await isar.habits.put(habit);
      });
    }

    // Refresh the list of habits
    readHabits();
  }

  // Update habit's name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        habit.name = newName;
        await isar.habits.put(habit);
      });
    }

    // Refresh the list of habits
    readHabits();
  }

  // Delete a habit from the database
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.habits.delete(id);
    });

    // Refresh the list of habits
    readHabits();
  }
}
