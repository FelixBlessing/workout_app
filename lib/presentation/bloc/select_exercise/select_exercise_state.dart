part of 'select_exercise_bloc.dart';

@immutable
sealed class SelectExerciseState {}

final class SelectExerciseInitial extends SelectExerciseState {}

final class LoadData extends SelectExerciseState {}

final class DataLoaded extends SelectExerciseState {
  final List<Exercise> allExercise;

  DataLoaded({required this.allExercise});
}
