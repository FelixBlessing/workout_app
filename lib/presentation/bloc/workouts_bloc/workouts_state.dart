part of 'workouts_bloc.dart';

@immutable
sealed class WorkoutsState {}

final class WorkoutsInitial extends WorkoutsState {}

final class WorkoutsDataIsLoading extends WorkoutsState {}

final class WorkoutsDataIsLoaded extends WorkoutsState {
  final List<Workout> workouts;
  final List<Exercise> exercise;

  WorkoutsDataIsLoaded({required this.workouts, required this.exercise});
}

final class WorkoutsHasError extends WorkoutsState {}
