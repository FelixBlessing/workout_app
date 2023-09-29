import 'dart:async';

import 'package:workout_app/infrastructure/models/workout.dart';

abstract class WorkoutRepository {
  final _controller = StreamController<List<Workout>>();

  Stream<List<Workout>> get workouts => _controller.stream.asBroadcastStream();

  void addToStream(List<Workout> workouts) => _controller.sink.add(workouts);

  Future<void> fetchAll({bool force = false});
  Future<Workout?> getOne(String itemId);
  Future<void> setOne(Workout workout);
  Future<void> deleteOne(String id);
}
