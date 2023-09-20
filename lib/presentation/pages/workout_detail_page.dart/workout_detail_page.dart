import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/dependency_injection.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:workout_app/presentation/bloc/workout_detail/workout_detail_bloc.dart';
import 'package:workout_app/presentation/global_widgets/dialogs.dart';
import 'package:workout_app/presentation/helper/routing.dart';
import 'package:workout_app/presentation/pages/select_exercise_page/select_exercise_page.dart';

class WorkoutDetailPage extends StatelessWidget {
  const WorkoutDetailPage({super.key, this.workouts});
  final Workout? workouts;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController =
        TextEditingController(text: workouts?.name);
    final FocusNode focusNode = FocusNode();
    return BlocProvider(
      create: (context) =>
          sl<WorkoutDetailBloc>()..add(InitializeWorkout(workout: workouts)),
      child: BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
        builder: (context, state) {
          if (state is WorkoutDetailStateInitialized) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                title: Text(state.workout.name),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDeleteDialog(context,
                          confirmationFunction: () =>
                              Navigator.of(context).pop(),
                          title: state.workout.name);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding, vertical: kDefaultPadding),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onTapOutside: (event) => focusNode.unfocus(),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                        label: Text("Workout-Name"),
                        alignLabelWithHint: true,
                        prefixIcon: Icon(Icons.fitness_center),
                      ),
                    ),
                    const SizedBox(
                      height: kBigPadding,
                    ),
                    const Divider(),
                    const Text(
                      "Übungen",
                      style: textStyleMedium,
                    ),
                    Expanded(
                        child: SelectedExerciseList(
                            exercise: state.workout.exercise)),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  navigateTo(
                      context,
                      SelectExercisePage(
                        alreadyCheckedExercise: state.workout.exercise,
                        onSave: (List<Exercise> exercise) => context
                            .read<WorkoutDetailBloc>()
                            .add(AddExercise(exercise: exercise)),
                      ));
                },
                child: const Icon(Icons.add),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class SelectedExerciseList extends StatelessWidget {
  const SelectedExerciseList({super.key, required this.exercise});
  final List<Exercise> exercise;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: exercise.length, // Anzahl der Listenelemente
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(exercise[index].name),
          trailing: IconButton(
            onPressed: () => context
                .read<WorkoutDetailBloc>()
                .add(RemoveExercise(exercise: exercise[index])),
            icon: const Icon(Icons.close),
          ),
        );
      },
    );
  }
}
