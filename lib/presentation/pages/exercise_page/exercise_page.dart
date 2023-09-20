import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/presentation/bloc/workouts_bloc/workouts_bloc.dart';

import '../../../constants.dart';
import '../../../infrastructure/models/exercise.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key, required this.exercise});
  final List<Exercise> exercise;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<WorkoutsBloc>().add(LoadData()),
      child: ListView.builder(
        itemCount: exercise.length,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kSmallPadding,
        ),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(exercise[index].name),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () => print("clicked on exercise"),
          );
        },
      ),
    );
  }
}
