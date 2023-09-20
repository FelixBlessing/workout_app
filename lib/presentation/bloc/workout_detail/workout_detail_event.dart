part of 'workout_detail_bloc.dart';

@immutable
sealed class WorkoutDetailEvent {}

class InitializeWorkout extends WorkoutDetailEvent {
  final Workout? workout;

  InitializeWorkout({this.workout});
}

class AddExercise extends WorkoutDetailEvent {
  final List<Exercise> exercise;
  AddExercise({required this.exercise});
}

class RemoveExercise extends WorkoutDetailEvent {
  final Exercise exercise;
  RemoveExercise({required this.exercise});
}

class SaveWorkout extends WorkoutDetailEvent {}
