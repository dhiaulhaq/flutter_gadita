import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gadita/model/network_test.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/stock_opname_detail_screen.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ChartScreen extends StatefulWidget {

  final int idPeriod;
  ChartScreen({Key key, @required this.idPeriod}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState(idPeriod);
}

class _ChartScreenState extends State<ChartScreen> {
  int idPeriod;
  _ChartScreenState(this.idPeriod);

  var logger = Logger;

  List<StockOpname> opnames = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchSummary();
  }

  Future<List<StockOpname>> fetchSummary() async {
    final response = await http.get('http://192.168.0.6:8000/api/period/'+idPeriod.toString());

    var parsed = json.decode(response.body);
    // print(parsed.length);
    List jsonResponse = parsed["data"] as List;

    setState(() {
      opnames = jsonResponse.map((job) => new StockOpname.fromJson(job)).toList();
      loading = false;
    });

    return json.decode(response.body);
  }

  List<charts.Series<StockOpname, String>> _createSampleData() {
    return [
      charts.Series<StockOpname, String>(
        data: opnames,
        id: 'sales',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        // labelAccessorFn: (StockOpname opnameModel, _) => '${opnameModel.assetName}: ${opnameModel.percentage}%',
        domainFn: (StockOpname opnameModel, _) => opnameModel.assetName,
        measureFn: (StockOpname opnameModel, _) => opnameModel.percentage,
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
        title: Text('Lending Percentage', style: TextStyle(color: Colors.black)),
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
                "Asset Lending Percentage",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 10,),
              Text(
                "Percentage calculation:",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Text(
                "Lending / 30 (Days) x 100.",
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