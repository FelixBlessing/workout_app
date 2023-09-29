import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:workout_app/infrastructure/repositories/workout_repository_impl.dart';

part 'workout_detail_event.dart';
part 'workout_detail_state.dart';

class WorkoutDetailBloc extends Bloc<WorkoutDetailEvent, WorkoutDetailState> {
  final WorkoutRepositoryImpl _workoutRepositoryImpl;
  WorkoutDetailBloc(this._workoutRepositoryImpl)
      : super(WorkoutDetailStateUnitialized()) {
    on<InitializeWorkout>(
      (event, emit) async {
        emit(WorkoutDetailStateInitialized(
            workout: await _workoutRepositoryImpl.getOne(event.workoutId) ??
                Workout.empty()));
      },
    );

    on<AddExercise>((event, emit) {
      if (state is WorkoutDetailStateInitialized) {
        final initializedState = state as WorkoutDetailStateInitialized;
        final Exercise exercise = Exercise.empty();
        List<Exercise> newExerciseList =
            List.from(initializedState.workout.exercise);
        newExerciseList.add(exercise);

        emit(initializedState.copyWith(
            workout:
                initializedState.workout.copyWith(exercise: newExerciseList)));
      }
    });
    on<RemoveExercise>((event, emit) {
      if (state is WorkoutDetailStateInitialized) {
        final initializedState = state as WorkoutDetailStateInitialized;
        final List<Exercise> newExerciseList = initializedState.workout.exercise
            .where((exercise) => exercise.id != event.id)
            .toList();

        emit(initializedState.copyWith(
            workout:
                initializedState.workout.copyWith(exercise: newExerciseList)));
      }
    });

    on<DeleteWorkout>((event, emit) async {
      await _workoutRepositoryImpl.deleteOne(event.workoutId);
    });
  }
}
