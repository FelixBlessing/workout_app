import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/infrastructure/dummy_data/Exercise_data.dart';
import 'package:workout_app/infrastructure/dummy_data/workout_detail.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';
import 'package:workout_app/infrastructure/models/workout.dart';

part 'workouts_event.dart';
part 'workouts_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial()) {
    on<LoadData>((event, emit) async {
      emit(WorkoutsDataIsLoading());
      final List<Workout> workouts = workoutDummyData;
      final List<Exercise> exercise = exerciseDummyDate;
      await Future.delayed(const Duration(seconds: 1));
      emit(WorkoutsDataIsLoaded(workouts: workouts, exercise: exercise));
    });
  }
}
