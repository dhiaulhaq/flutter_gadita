import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gadita/model/lending.dart';
import 'package:gadita/model/network_test.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/stock_opname_detail_screen.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class CompareMonthScreen extends StatefulWidget {

  final Map idPeriod;
  CompareMonthScreen({Key key, @required this.idPeriod}) : super(key: key);

  @override
  _CompareMonthScreenState createState() => _CompareMonthScreenState(idPeriod);
}

class _CompareMonthScreenState extends State<CompareMonthScreen> {
  Map idPeriod;
  _CompareMonthScreenState(this.idPeriod);

  var logger = Logger;

  List<Lending> lendings = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchSummary();
  }

  Future<List<Lending>> fetchSummary() async {
    final response = await http.get('http://192.168.0.6:8000/api/lending-count/'+widget.idPeriod['year'].toString());

    var parsed = json.decode(response.body);
    // print(parsed.length);
    List jsonResponse = parsed["data"] as List;

    setState(() {
      lendings = jsonResponse.map((job) => new Lending.fromJson(job)).toList();
      loading = false;
    });

    return json.decode(response.body);
  }

  List<charts.Series<Lending, String>> _createSampleData() {
    return [
      charts.Series<Lending, String>(
        data: lendings,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        // labelAccessorFn: (Lending opnameModel, _) => '${opnameModel.assetName}: ${opnameModel.percentage}%',
        domainFn: (Lending lendingModel, _) => lendingModel.month,
        measureFn: (Lending lendingModel, _) => lendingModel.precentage,
      )
    ];
  }

  String url = 'http://192.168.0.6:8000/api/stock_opname';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Monthly Percentage', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>StockOpnameScreen(),
          )),
        ),
      ),
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
          padding: EdgeInsets.all(10),
          height: 500,
          child: Column(
            children: [
              Text(
                "Monthly Lending Percentage",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10,),
              Text(
                "Percentage calculation:",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "Lending / 365 (Days) x 100.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child: charts.BarChart(
                  _createSampleData(),
                  animate: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}