import 'package:hive/hive.dart';

const achievements = [
  'objects',
  'clear-glass',
  'colored-glass',
  'clothing',
  'metal',
  'paper-cardboard',
  'plastic',
  'trash',
  'open_app_separate_days',
  'last_open_update',
];

class Database {
  final box = Hive.box<int>('achievements');

  void initializeAchievements() {
    for (final achievement in achievements) {
      box.put(achievement, 0);
    }
  }

  void updateObjectAchievements(Map<String, dynamic>? data) {
    final String label = data!['label'];
    final int labelCount = box.get(label) ?? 0;
    box.put(label, labelCount + 1);

    final int objects = box.get('objects') ?? 0;
    box.put('objects', objects + 1);
  }

  void updateAppOpenAchievement() {
    const int millisecondsInADay = 86400000;

    final int now = DateTime.now().millisecondsSinceEpoch;
    final int lastUpdated = box.get('open_app_separate_days') ?? 0;

    if (now - lastUpdated > millisecondsInADay) {
      final count = box.get('open_app_separate_days') ?? 0;

      box
        ..put('open_app_separate_days', count + 1)
        ..put('last_open_update', now);
    }
  }

  Map<dynamic, int> getAchievementData() {
    final List<dynamic> keys = box.keys.toList();
    final List<int> values = box.values.toList();
    return Map.fromIterables(keys, values);
  }
}
