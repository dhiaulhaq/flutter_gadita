import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/barcode_detail_screen.dart';
import 'package:gadita/screens/chart_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/lending_screen.dart';
import 'package:gadita/screens/stock_opname_addQty_screen.dart';
import 'package:gadita/screens/stock_opname_scan_screen.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:gadita/screens/test_purpose_only.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class StockOpnameDetail extends StatefulWidget{

  final Map period;
  StockOpnameDetail({@required this.period});

  @override
  _StockOpnameDetailState createState() => _StockOpnameDetailState();
}

class _StockOpnameDetailState extends State<StockOpnameDetail> {
  var logger = Logger();

  Future<List<StockOpname>> fetchSummary() async {
    final response = await http.get('http://192.168.0.6:8000/api/period/'+widget.period['id'].toString());

    if (response.statusCode == 200) {
      // var data =
      // '{ "Global": { "NewConfirmed": 100282, "TotalConfirmed": 1162857, "NewDeaths": 5658, "TotalDeaths": 63263, "NewRecovered": 15405, "TotalRecovered": 230845 }, "Countries": [ { "Country": "ALA Aland Islands", "CountryCode": "AX", "Slug": "ala-aland-islands", "NewConfirmed": 0, "TotalConfirmed": 0, "NewDeaths": 0, "TotalDeaths": 0, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" },{ "Country": "Zimbabwe", "CountryCode": "ZW", "Slug": "zimbabwe", "NewConfirmed": 0, "TotalConfirmed": 9, "NewDeaths": 0, "TotalDeaths": 1, "NewRecovered": 0, "TotalRecovered": 0, "Date": "2020-04-05T06:37:00Z" } ], "Date": "2020-04-05T06:37:00Z" }';
      var parsed = json.decode(response.body);
      // print(parsed.length);
      List jsonResponse = parsed["data"] as List;

      logger.d('${response.body}');
      return jsonResponse.map((job) => new StockOpname.fromJson(job)).toList();
    } else {
      print('Error, Could not load Data.');
      throw Exception('Failed to load Data');
    }
  }

  final controller = ScrollController();
  double offset = 0;

  Future<List<StockOpname>> _func;

  @override
  void initState() {
    _func = fetchSummary();
    controller.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.6:8000/api/period/" + assetId;
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteAssets(widget.period['id'].toString()).then((value) {
                  setState(() {});
                });
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context)=>StockOpnameScreen(),
                ));
              },
            ),
          ],
        );
      },
    );
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
            builder: (context)=>ChartScreen(idPeriod: widget.period['id']),
            // builder: (context)=>BarChartAPI(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Stock Opname Detail', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => _showMyDialog(),
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>StockOpnameScreen(),
          )),
        ),
      ),
      body: FutureBuilder<List<StockOpname>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
          // if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                  child: Text(
                    "No data recorded, please click button below to start new stock opname.",
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>StockOpnameScan(idPeriod: widget.period['id']),
                        // builder: (context)=>StockOpnameAddQty(idPeriod: widget.period['id']),
                        // builder: (context)=>DataTableDemo(),
                      ),
                    );
                  },
                  child: Text("Start"),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                'An Error Occured!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              content: Text(
                "${snapshot.error}",
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          } else {
            List<StockOpname> data = snapshot.data;
            // print(data);
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: Text(
                        'Date: '+widget.period['day']+', '+widget.period['period'],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Center(
                      child: Text(
                        'User: Naufal',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Center(
                      child: Text(
                        'Note: Swipe left the table to see more data',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          sortColumnIndex: 0,
                          sortAscending: true,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Asset',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Asset Name",
                            ),
                            DataColumn(
                              label: Text(
                                'Asset Code',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: false,
                              tooltip: "Asset Code",
                            ),
                            DataColumn(
                              label: Text(
                                'Qty',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Qty",
                            ),
                            DataColumn(
                              label: Text(
                                'Lending',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Lending",
                            ),
                            DataColumn(
                              label: Text(
                                'Percentage',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              numeric: true,
                              tooltip: "Percentage",
                            ),
                          ],
                          rows: data
                              .map(
                                (asset) => DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: 100,
                                    child: Text(
                                      asset.assetName,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 60.0,
                                    child: Center(
                                      child: Text(
                                        asset.assetCode,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      asset.qty.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      asset.lending.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      asset.percentage.toString()+"%",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 500),
                ],
              ),
            );
          }
          // By default, show a loading spinner.
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading...')
              ],
            ),
          );
        },
      ),
    );
  }
}