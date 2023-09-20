part of 'workouts_bloc.dart';

@immutable
sealed class WorkoutsEvent {}

class LoadData extends WorkoutsEvent {}
