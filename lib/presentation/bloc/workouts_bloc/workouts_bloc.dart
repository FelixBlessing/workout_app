import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:workout_app/infrastructure/repositories/workout_repository_impl.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  StreamSubscription<List<Workout>>? _subscription;
  final WorkoutRepositoryImpl _workoutRepository;
  WorkoutsBloc(this._workoutRepository) : super(WorkoutsInitial()) {
    /// Listens for workout changes
    _subscription = _workoutRepository.workouts.listen((workouts) {
      add(UpdateWorkouts(workouts: workouts));
    });

    on<UpdateWorkouts>((event, emit) {
      emit(WorkoutsDataIsLoaded(workouts: event.workouts));
    });

    on<LoadData>((event, emit) async {
      emit(WorkoutsDataIsLoading());
      await _workoutRepository.fetchAll(force: event.force);
    });

    on<AddNewWorkout>((event, emit) {
      if (state is WorkoutsDataIsLoaded) {
        final isLoadedState = state as WorkoutsDataIsLoaded;
        List<Workout> newWorkouts = List.from(isLoadedState.workouts);
        newWorkouts.add(event.workout);
        emit(isLoadedState.copyWith(workouts: newWorkouts));
      }
    });

    on<EditWorkout>((event, emit) {
      if (state is WorkoutsDataIsLoaded) {
        final isLoadedState = state as WorkoutsDataIsLoaded;
        final List<Workout> newWorkouts = isLoadedState.workouts.map((workout) {
          if (workout.id == event.workout.id) {
            return event.workout;
          }
          return workout;
        }).toList();
        emit(isLoadedState.copyWith(workouts: newWorkouts));
      }
    });
  }
  @override
  Future<void> close() async {
    await _subscription?.cancel();
    super.close();
  }
}
