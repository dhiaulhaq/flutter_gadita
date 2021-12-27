import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gadita/model/network_test.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/stock_opname_detail_screen.dart';
import 'package:gadita/screens/stock_opname_result_screen.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:logger/logger.dart';

class ChartResultScreen extends StatefulWidget {

  final int idPeriod;
  ChartResultScreen({Key key, @required this.idPeriod}) : super(key: key);

  @override
  _ChartResultScreenState createState() => _ChartResultScreenState(idPeriod);
}

class _ChartResultScreenState extends State<ChartResultScreen> {
  int idPeriod;
  _ChartResultScreenState(this.idPeriod);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>StockOpnameScreen(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Lending Percentage', style: TextStyle(color: Colors.black)),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(
        //     builder: (context)=>StockOpnameResult(),
        //   )),
        // ),
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