import 'package:hive/hive.dart';

class Database {
  final box = Hive.box<int>('achievements');

  void initializeAchievements() {
    box.put('objects', 0);
  }

  int updateAchievement(Map<String, dynamic>? data) {
    int objects;

    objects = box.get('objects') ?? 0;

    box.put('objects', objects + 1);
    return objects;
  }

  List<int> getAchievementData() => box.values.toList();

  void resetAchievements() => box.put('objects', 0);
}
