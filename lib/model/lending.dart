import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class Lending {
  final String user;
  final String period;
  final int year;
  final String month;
  final String day;
  final int precentage;

  Lending({
    this.user,
    this.period,
    this.year,
    this.month,
    this.day,
    this.precentage,
  });

  factory Lending.fromJson(Map<String, dynamic> json) {
    return Lending(
      user: json['user'],
      period: json['period'],
      year: json['year'],
      month: json['month'],
      day: json['day'],
      precentage: json['precentage'],
    );
  }
}