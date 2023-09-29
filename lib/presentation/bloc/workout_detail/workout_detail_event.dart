part of 'workout_detail_bloc.dart';

@immutable
sealed class WorkoutDetailEvent {}

class InitializeWorkout extends WorkoutDetailEvent {
  final String? workoutId;

  InitializeWorkout({this.workoutId});
}

class DeleteWorkout extends WorkoutDetailEvent {
  final String workoutId;
  DeleteWorkout({required this.workoutId});
}

class AddExercise extends WorkoutDetailEvent {}

class RemoveExercise extends WorkoutDetailEvent {
  final String id;
  RemoveExercise({required this.id});
}

class SaveWorkout extends WorkoutDetailEvent {}
