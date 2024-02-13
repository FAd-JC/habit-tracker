import 'package:isar/isar.dart';
part 'app_preferences.g.dart';

@Collection()
class AppPreferences {
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}
