import 'package:hive/hive.dart';

class DatabaseService {
  Future<int> updateAchievement() async {
    final box = Hive.box<int>('achievements');
    int objects;

    objects = box.get('objects', defaultValue: 0) ?? 0;

    await box.put('objects', objects + 1);
    return objects;
  }
}
