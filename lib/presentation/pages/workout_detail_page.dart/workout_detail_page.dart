import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/infrastructure/models/exercise.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:workout_app/infrastructure/repositories/workout_repository_impl.dart';
import 'package:workout_app/presentation/bloc/workout_detail/workout_detail_bloc.dart';
import 'package:workout_app/presentation/global_widgets/dialogs.dart';

class WorkoutDetailPage extends StatelessWidget {
  const WorkoutDetailPage({super.key, this.workoutId});
  final String? workoutId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WorkoutDetailBloc(context.read<WorkoutRepositoryImpl>())
            ..add(InitializeWorkout(workoutId: workoutId)),
      child: BlocBuilder<WorkoutDetailBloc, WorkoutDetailState>(
        builder: (context, state) {
          if (state is WorkoutDetailStateInitialized) {
            return WorkoutDetailView(workout: state.workout);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class WorkoutDetailView extends StatelessWidget {
  const WorkoutDetailView({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textEditingController =
        TextEditingController(text: workout.name);
    final FocusNode focusNode = FocusNode();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
        title: Text(workout.name),
        actions: [
          IconButton(
            onPressed: () {
              showDeleteDialog(context, confirmationFunction: () {
                context
                    .read<WorkoutDetailBloc>()
                    .add(DeleteWorkout(workoutId: workout.id));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }, title: workout.name);
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
                key: ValueKey(workout.exercise),
                exercise: workout.exercise,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        onPressed: () {
          context.read<WorkoutDetailBloc>().add(AddExercise());
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SelectedExerciseList extends StatefulWidget {
  const SelectedExerciseList({super.key, required this.exercise});
  final List<Exercise> exercise;

  @override
  State<SelectedExerciseList> createState() => _SelectedExerciseListState();
}

class _SelectedExerciseListState extends State<SelectedExerciseList> {
  List<TextEditingController> textControllersNames = [];
  List<TextEditingController> textControllersSets = [];
  List<TextEditingController> textControllersRepetitions = [];
  @override
  void dispose() {
    for (var controller in textControllersNames) {
      controller.dispose();
    }
    for (var controller in textControllersSets) {
      controller.dispose();
    }
    for (var controller in textControllersRepetitions) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.exercise.length, // Anzahl der Listenelemente
      itemBuilder: (context, index) {
        createTextEditingController(widget.exercise[index]);
        return ExpansionTile(
          initiallyExpanded: widget.exercise[index].checked,
          backgroundColor: Colors.grey.shade100,
          maintainState: true,
          title: TextField(
            controller: textControllersNames[index],
          ),
          trailing: IconButton(
            onPressed: () => context
                .read<WorkoutDetailBloc>()
                .add(RemoveExercise(id: widget.exercise[index].id)),
            icon: const Icon(Icons.delete_outline),
          ),
          children: [
            TextField(
              controller: textControllersSets[index],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Anzahl Sätze"),
                prefixIcon: Icon(Icons.numbers_outlined),
              ),
            ),
            TextField(
              controller: textControllersRepetitions[index],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                label: Text("Anzahl Wiederholungen"),
                prefixIcon: Icon(Icons.numbers_outlined),
              ),
            ),
          ],
        );
      },
    );
  }

  void createTextEditingController(Exercise exercise) {
    final String name = exercise.name;
    final String? sets = exercise.numberOfSets?.toString();
    final String? repetition = exercise.numberOfRepetition?.toString();
    textControllersNames.add(TextEditingController(text: name));
    textControllersSets.add(TextEditingController(text: sets));
    textControllersRepetitions.add(TextEditingController(text: repetition));
  }
}
