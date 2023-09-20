import 'package:uuid/uuid.dart';

import 'exercise.dart';

class Workout {
  final String id;
  final String name;
  final List<Exercise> exercise;

  Workout({required this.id, required this.name, required this.exercise});

  factory Workout.empty() =>
      Workout(id: const Uuid().v4(), name: "Neues Workout", exercise: []);

  Workout copyWith({
    String? id,
    String? name,
    List<Exercise>? exercise,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      exercise: exercise ?? this.exercise,
    );
  }
}
