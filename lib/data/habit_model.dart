class Habit {
  final int? id;
  final String title;
  final String frequency;
  final int completedCount;
  final String? lastCompleted;

  Habit({
    this.id,
    required this.title,
    required this.frequency,
    this.completedCount = 0,
    this.lastCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'frequency': frequency,
      'completed_count': completedCount,
      'last_completed': lastCompleted,
    };
  }

  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      title: map['title'],
      frequency: map['frequency'],
      completedCount: map['completed_count'],
      lastCompleted: map['last_completed'],
    );
  }

  Habit copyWith({
    int? id,
    String? title,
    String? frequency,
    int? completedCount,
    String? lastCompleted,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      frequency: frequency ?? this.frequency,
      completedCount: completedCount ?? this.completedCount,
      lastCompleted: lastCompleted ?? this.lastCompleted,
    );
  }
}
