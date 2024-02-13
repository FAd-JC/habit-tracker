import 'package:isar/isar.dart';
part 'habit.g.dart'; //run in cmd to generate file: dart run build_runner build

@Collection()
class Habit {
  //habit id
  Id id = Isar.autoIncrement;
  //habit name
  late String name;

  //habit completed days
  List<DateTime> daysCompleted = [
    //datetime (day month year)
    //datetime (12, 2, 2024)
    //datetime(12, 2, 2024)
  ];
}
