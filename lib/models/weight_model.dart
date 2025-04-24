class WeightEntry {
  final int id;
  final String date;
  final double weight;

  WeightEntry({
    required this.id,
    required this.date,
    required this.weight,
  });

  factory WeightEntry.fromJson(Map<String, dynamic> json) {
    return WeightEntry(
      id: json['id'],
      date: json['date'],
      weight: double.tryParse(json['weight'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'weight': weight,
      };
}
