import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';
import 'package:workout_app/infrastructure/models/workout.dart';

part 'workout_detail_event.dart';
part 'workout_detail_state.dart';

class WorkoutDetailBloc extends Bloc<WorkoutDetailEvent, WorkoutDetailState> {
  WorkoutDetailBloc() : super(WorkoutDetailStateUnitialized()) {
    on<InitializeWorkout>(
      (event, emit) {
        emit(WorkoutDetailStateInitialized(
            workout: event.workout ?? Workout.empty()));
      },
    );

    on<AddExercise>((event, emit) {
      if (state is WorkoutDetailStateInitialized) {
        final initializedState = state as WorkoutDetailStateInitialized;
        final List<Exercise> newExerciseList = event.exercise
            .where((exercise) => exercise.checked == true)
            .toList();

        emit(initializedState.copyWith(
            workout:
                initializedState.workout.copyWith(exercise: newExerciseList)));
      }
    });
    on<RemoveExercise>((event, emit) {
      if (state is WorkoutDetailStateInitialized) {
        final initializedState = state as WorkoutDetailStateInitialized;
        final List<Exercise> newExerciseList =
            List.from(initializedState.workout.exercise);
        newExerciseList.remove(event.exercise);

        emit(initializedState.copyWith(
            workout:
                initializedState.workout.copyWith(exercise: newExerciseList)));
      }
    });
  }
}
