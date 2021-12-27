import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/chart_result_screen.dart';
import 'package:gadita/screens/chart_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class StockOpnameResult extends StatefulWidget {

  final int idPeriod;
  StockOpnameResult({Key key, @required this.idPeriod}) : super(key: key);

  @override
  _StockOpnameResult createState() => _StockOpnameResult(idPeriod);
}

class _StockOpnameResult extends State<StockOpnameResult> {

  int idPeriod;
  _StockOpnameResult(this.idPeriod);

  var logger = Logger();
  // String url = 'http://192.168.0.9:8000/api/stock_opname/result';
  //
  // Future getProducts() async {
  //   var response = await http.get(Uri.parse(url));
  //   // print(json.decode(response.body));
  //   logger.d('${response.body}');
  //   return json.decode(response.body);
  // }

  Future<List<StockOpname>> fetchSummary() async {
    final response = await http.get('http://192.168.0.6:8000/api/santet/'+idPeriod.toString());

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

  final formatPeriod = new DateFormat('dd-MM-yyyy');
  final formatDay = new DateFormat('E');

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.keyboard_arrow_right),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context)=>ChartResultScreen(idPeriod: idPeriod),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Stock Opname Result', style: TextStyle(color: Colors.black)),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.push(
        //       context, MaterialPageRoute(
        //     builder: (context)=>HomeScreen(),
        //   )),
        // ),
      ),
      body: FutureBuilder<List<StockOpname>>(
        future: _func,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
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
                        formatDay.format(new DateTime.now()).toString()+', '+formatPeriod.format(new DateTime.now()).toString(),
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
                                (country) => DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: 100,
                                    child: Text(
                                      country.assetName,
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
                                        country.assetCode,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      country.qty.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      country.lending.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: Text(
                                      country.percentage.toString()+"%",
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