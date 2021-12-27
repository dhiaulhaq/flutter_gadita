import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class StockOpname {
  final String assetName;
  final String assetCode;
  final int qty;
  final int lending;
  final int percentage;
  final int year;
  final String month;

  StockOpname({
    this.assetName,
    this.assetCode,
    this.qty,
    this.lending,
    this.percentage,
    this.year,
    this.month,
  });

  factory StockOpname.fromJson(Map<String, dynamic> json) {
    return StockOpname(
      assetName: json['asset_name'],
      assetCode: json['asset_code'],
      qty: json['qty_asset_master'],
      lending: json['total_lending'],
      percentage: json['percentage'],
      year: json['year'],
      month: json['month'],
    );
  }
}