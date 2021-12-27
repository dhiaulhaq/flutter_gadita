import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gadita/model/stock_opname.dart';
import 'developer_series.dart';

class DeveloperChart extends StatelessWidget {
  final List<StockOpname> data;

  DeveloperChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<StockOpname, String>> series = [
      charts.Series(
          id: "developers",
          data: data,
          domainFn: (StockOpname series, _) => series.assetName,
          measureFn: (StockOpname series, _) => series.percentage,
      )
    ];

    return Container(
      height: 300,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Yearly Growth in the Flutter Community",
                style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }

}