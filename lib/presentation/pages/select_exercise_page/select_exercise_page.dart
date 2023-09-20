import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/presentation/bloc/select_exercise/select_exercise_bloc.dart';

import '../../../constants.dart';
import '../../../dependency_injection.dart';
import '../../../infrastructure/models/exercise.dart';

class SelectExercisePage extends StatelessWidget {
  const SelectExercisePage(
      {super.key, required this.alreadyCheckedExercise, required this.onSave});
  final List<Exercise> alreadyCheckedExercise;
  final void Function(List<Exercise> exercise) onSave;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SelectExerciseBloc>()
        ..add(LoadExercise(alreadyAddedExercise: alreadyCheckedExercise)),
      child: BlocBuilder<SelectExerciseBloc, SelectExerciseState>(
        builder: (context, state) {
          if (state is LoadData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DataLoaded) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Wähle deine Übungen aus"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final state = context.read<SelectExerciseBloc>().state;
                        if (state is DataLoaded) {
                          onSave(state.allExercise);
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Speichern"),
                    )
                  ],
                ),
                body: ListView.builder(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  itemCount: state.allExercise.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      initiallyExpanded: state.allExercise[index].checked,
                      backgroundColor: Colors.grey.shade100,
                      maintainState: true,
                      onExpansionChanged: (value) {
                        context.read<SelectExerciseBloc>().add(CheckExercise(
                            id: state.allExercise[index].id, checked: value));
                      },
                      title: Text(state.allExercise[index].name),
                      trailing: state.allExercise[index].checked
                          ? const Icon(Icons.check_box_outlined)
                          : const Icon(Icons.check_box_outline_blank),
                      children: const [
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("Anzahl Sätze"),
                            prefixIcon: Icon(Icons.numbers_outlined),
                          ),
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            label: Text("Anzahl Wiederholungen"),
                            prefixIcon: Icon(Icons.numbers_outlined),
                          ),
                        ),
                      ],
                    );
                  },
                ));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
