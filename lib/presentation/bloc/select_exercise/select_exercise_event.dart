part of 'select_exercise_bloc.dart';

@immutable
sealed class SelectExerciseEvent {}

class LoadExercise extends SelectExerciseEvent {
  final List<Exercise> alreadyAddedExercise;

  LoadExercise({required this.alreadyAddedExercise});
}

class CheckExercise extends SelectExerciseEvent {
  final String id;
  final bool checked;
  CheckExercise({required this.id, required this.checked});
}
