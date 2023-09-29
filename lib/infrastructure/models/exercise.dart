import 'package:uuid/uuid.dart';

class Exercise {
  final String id;
  final String name;
  final bool checked;
  final int? numberOfSets;
  final int? numberOfRepetition;

  const Exercise({
    required this.id,
    required this.name,
    required this.checked,
    this.numberOfSets,
    this.numberOfRepetition,
  });

  factory Exercise.empty() =>
      Exercise(id: const Uuid().v4(), name: "Neue Übung", checked: false);

  Exercise copyWith({
    String? id,
    String? name,
    bool? checked,
    int? numberOfSets,
    int? numberOfRepetition,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      checked: checked ?? this.checked,
      numberOfSets: numberOfSets ?? this.numberOfSets,
      numberOfRepetition: numberOfRepetition ?? this.numberOfRepetition,
    );
  }
}
