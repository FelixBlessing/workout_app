import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workout_app/constants.dart';
import 'package:workout_app/infrastructure/models/workout.dart';
import 'package:workout_app/infrastructure/repositories/workout_repository_impl.dart';
import 'package:workout_app/presentation/bloc/login/authentication/authentication_bloc.dart';
import 'package:workout_app/presentation/bloc/workouts_bloc/workouts_bloc.dart';
import 'package:workout_app/presentation/helper/routing.dart';
import 'package:workout_app/presentation/pages/workout_detail_page.dart/workout_detail_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WorkoutsBloc(context.read<WorkoutRepositoryImpl>())..add(LoadData()),
      child:
          BlocBuilder<WorkoutsBloc, WorkoutsState>(builder: (context, state) {
        if (state is WorkoutsDataIsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is WorkoutsDataIsLoaded) {
          return DataLoaded(
            workouts: state.workouts,
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

class DataLoaded extends StatelessWidget {
  const DataLoaded({super.key, required this.workouts});
  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workouts"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogOut());
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: WorkoutPage(
        workouts: workouts,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateTo(
          context,
          const WorkoutDetailPage(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({
    super.key,
    required this.workouts,
  });
  final List<Workout> workouts;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<WorkoutsBloc>().add(LoadData(force: true)),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kSmallPadding,
        ),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          return WorkoutListItem(
            workout: workouts[index],
          );
        },
      ),
    );
  }
}

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem({super.key, required this.workout});
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workout.name),
      subtitle: Text("${workout.exercise.length} Übungen"),
      trailing: const Icon(Icons.arrow_forward_ios_rounded),
      onTap: () => print("start workout"),
      onLongPress: () => navigateTo(
          context,
          WorkoutDetailPage(
            workoutId: workout.id,
          )),
    );
  }
}
