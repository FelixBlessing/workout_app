part of 'workouts_bloc.dart';

@immutable
sealed class WorkoutsState {}

final class WorkoutsInitial extends WorkoutsState {}

final class WorkoutsDataIsLoading extends WorkoutsState {}

final class WorkoutsDataIsLoaded extends WorkoutsState {
  final List<Workout> workouts;

  WorkoutsDataIsLoaded({required this.workouts});

  WorkoutsDataIsLoaded copyWith({
    List<Workout>? workouts,
  }) {
    return WorkoutsDataIsLoaded(
      workouts: workouts ?? this.workouts,
    );
  }
}

final class WorkoutsHasError extends WorkoutsState {}
