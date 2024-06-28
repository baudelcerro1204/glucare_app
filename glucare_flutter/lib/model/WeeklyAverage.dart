class WeeklyAverage {
  final int year;
  final int week;
  final double averageValue;

  WeeklyAverage({required this.year, required this.week, required this.averageValue});

  factory WeeklyAverage.fromJson(Map<String, dynamic> json) {
    return WeeklyAverage(
      year: json['year'],
      week: json['week'],
      averageValue: json['averageValue'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'week': week,
      'averageValue': averageValue,
    };
  }
}