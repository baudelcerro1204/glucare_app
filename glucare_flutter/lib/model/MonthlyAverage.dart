class MonthlyAverage {
  final int year;
  final int month;
  final double averageValue;

  MonthlyAverage({required this.year, required this.month, required this.averageValue});

  factory MonthlyAverage.fromJson(Map<String, dynamic> json) {
    return MonthlyAverage(
      year: json['year'],
      month: json['month'],
      averageValue: json['averageValue'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'averageValue': averageValue,
    };
  }
}