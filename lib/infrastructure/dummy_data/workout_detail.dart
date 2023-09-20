import 'package:uuid/uuid.dart';
import 'package:workout_app/infrastructure/dummy_data/Exercise_data.dart';
import 'package:workout_app/infrastructure/models/workout.dart';

final workoutDummyData = [
  Workout(id: const Uuid().v4(), name: "Test1", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test2", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test3", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test4", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test5", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test6", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test7", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test8", exercise: exerciseDummyDate),
  Workout(id: const Uuid().v4(), name: "Test9", exercise: exerciseDummyDate),
];
