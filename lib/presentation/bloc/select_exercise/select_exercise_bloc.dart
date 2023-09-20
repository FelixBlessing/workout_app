import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:workout_app/infrastructure/dummy_data/Exercise_data.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';

part 'select_exercise_event.dart';
part 'select_exercise_state.dart';

class SelectExerciseBloc
    extends Bloc<SelectExerciseEvent, SelectExerciseState> {
  SelectExerciseBloc() : super(SelectExerciseInitial()) {
    on<LoadExercise>((event, emit) {
      emit(LoadData());
      final List<Exercise> allExercise = exerciseDummyDate.map((exercise) {
        final foundExercise = event.alreadyAddedExercise
            .where((element) => element.id == exercise.id)
            .firstOrNull;
        return foundExercise?.copyWith(checked: true) ?? exercise;
      }).toList();
      emit(DataLoaded(allExercise: allExercise));
    });

    on<CheckExercise>((event, emit) {
      if (state is DataLoaded) {
        final dataLoadedState = state as DataLoaded;
        final List<Exercise> newExerciseList =
            dataLoadedState.allExercise.map((exercise) {
          if (exercise.id == event.id) {
            return exercise.copyWith(checked: event.checked);
          }
          return exercise;
        }).toList();
        emit(DataLoaded(allExercise: newExerciseList));
      }
    });
  }
}
