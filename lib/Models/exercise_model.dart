class Exercise {
  final String id;
  final String name;
  final String? description;
  final String type;
  final int? duration;
  final int? repetitions;
  final int? sets;
  final int? restPeriod;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    required this.type,
    this.duration,
    this.repetitions,
    this.sets,
    this.restPeriod,
  });
}
