class Period {
  final int id;
  final String user;
  final String period;
  final int year;
  final String month;

  Period({
    this.id,
    this.user,
    this.period,
    this.year,
    this.month,
  });

  factory Period.fromJson(Map<String, dynamic> json) {
    return Period(
      id: json['id'],
      user: json['user'],
      period: json['period'],
      year: json['year'],
      month: json['month'],
    );
  }
}