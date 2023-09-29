import 'package:workout_app/domain/repositories/workout_repository.dart';
import 'package:workout_app/infrastructure/dummy_data/workout_detail.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:collection/collection.dart';

class WorkoutRepositoryImpl extends WorkoutRepository {
  List<Workout> _currentWorkouts = [];
  @override
  Future<void> fetchAll({bool force = false}) async {
    if (_currentWorkouts.isEmpty || force == true) {
      await Future.delayed(const Duration(milliseconds: 400));
      _currentWorkouts = workoutDummyData;
    }

    addToStream(_currentWorkouts);
  }

  @override
  Future<Workout?> getOne(String? workoutId) async {
    if (_currentWorkouts.isEmpty) {
      await fetchAll();
    }
    try {
      return _currentWorkouts
          .firstWhereOrNull((workout) => workout.id == workoutId);
    } catch (e) {
      return null;
    }
  }

  void _updateCurrentItemsWith(Workout workout) {
    _currentWorkouts = _currentWorkouts.map((currentWorkout) {
      if (workout.id == currentWorkout.id) {
        return workout;
      }
      return currentWorkout;
    }).toList();
  }

  @override
  Future<void> setOne(Workout workout) async {
    _updateCurrentItemsWith(workout);
    addToStream(_currentWorkouts);
  }

  @override
  Future<void> deleteOne(String id) async {
    _currentWorkouts = _currentWorkouts
        .where((currentWorkout) => currentWorkout.id != id)
        .toList();
    addToStream(_currentWorkouts);
  }
}
