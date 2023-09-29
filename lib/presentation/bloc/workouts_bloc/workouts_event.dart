part of 'workouts_bloc.dart';

@immutable
sealed class WorkoutsEvent {}

class LoadData extends WorkoutsEvent {
  final bool force;
  LoadData({this.force = false});
}

class AddNewWorkout extends WorkoutsEvent {
  final Workout workout;

  AddNewWorkout({required this.workout});
}

class UpdateWorkouts extends WorkoutsEvent {
  final List<Workout> workouts;

  UpdateWorkouts({required this.workouts});
}

class EditWorkout extends WorkoutsEvent {
  final Workout workout;

  EditWorkout({required this.workout});
}
