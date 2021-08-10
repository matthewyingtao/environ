import 'package:hive/hive.dart';

class DatabaseService {
  DatabaseService({required this.data});
  final Map<String, dynamic>? data;
  final box = Hive.box<int>('achievements');

  int updateAchievement() {
    int objects;

    objects = box.get('objects', defaultValue: 0) ?? 0;

    box.put('objects', objects + 1);
    return objects;
  }

  List<int> getAchievementData() => box.values.toList();

  void resetAchievements() => box.put('objects', 0);
}
