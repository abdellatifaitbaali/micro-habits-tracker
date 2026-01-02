import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'habit_model.dart';

class HabitProvider with ChangeNotifier {
  List<Habit> _habits = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Habit> get habits => _habits;

  Future<void> fetchHabits() async {
    try {
      final data = await _dbHelper.getHabits();
      _habits = data.map((e) => Habit.fromMap(e)).toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching habits: $e');
    }
  }

  Future<void> addHabit(String title, String frequency) async {
    final newHabit = Habit(title: title, frequency: frequency);
    await _dbHelper.insertHabit(newHabit.toMap());
    await fetchHabits();
  }

  Future<void> toggleHabitCompletion(Habit habit) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    if (habit.lastCompleted == today) return; // Already completed today

    final updatedHabit = habit.copyWith(
      completedCount: habit.completedCount + 1,
      lastCompleted: today,
    );
    await _dbHelper.updateHabit(updatedHabit.toMap());
    await fetchHabits();
  }

  Future<void> deleteHabit(int id) async {
    await _dbHelper.deleteHabit(id);
    await fetchHabits();
  }

  Future<void> clearAllData() async {
    await _dbHelper.deleteAllData();
    _habits = [];
    notifyListeners();
  }
}
