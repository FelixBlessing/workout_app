part of 'workout_detail_bloc.dart';

sealed class WorkoutDetailState {}

class WorkoutDetailStateUnitialized extends WorkoutDetailState {}

class WorkoutDetailStateInitialized extends WorkoutDetailState {
  final Workout workout;

  WorkoutDetailStateInitialized({required this.workout});

  WorkoutDetailStateInitialized copyWith({Workout? workout}) {
    return WorkoutDetailStateInitialized(workout: workout ?? this.workout);
  }
}
