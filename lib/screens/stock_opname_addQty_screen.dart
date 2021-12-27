import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/main.dart';
import 'package:gadita/model/stock_opname.dart';
import 'package:gadita/screens/add_asset_screen.dart';
import 'package:gadita/screens/assets_detail_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/stock_opname_result_screen.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class StockOpnameAddQty extends StatefulWidget{

  final int idPeriod;
  StockOpnameAddQty({Key key, @required this.idPeriod}) : super(key: key);

  @override
  _StockOpnameAddQty createState() => _StockOpnameAddQty(idPeriod);
}

class _StockOpnameAddQty extends State<StockOpnameAddQty> {

  var logger = Logger();

  int idPeriod;
  _StockOpnameAddQty(this.idPeriod);

  TextEditingController _qtyController = TextEditingController();

  List<String> item = ['233', '34'];
  Future sendCode() async{

    Map<String, dynamic> args = {"data_asset": _qtyController};
    var body = json.encode(args);

    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/qty"),
      headers: {
        'Content-type': 'application/json'
      },
      body: body,
    );

    logger.d('${response.body}');

    return json.decode(response.body);
  }

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
          sendCode();
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>StockOpnameResult(idPeriod: idPeriod),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Input Qty', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>HomeScreen(),
          )),
        ),
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
                    padding: EdgeInsets.only(top:20.0, left: 20.0, right: 20.0),
                    child: Text(
                        'Input qty for updating asset master qty (Optional). Click arrow button to continue.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                              ),
                              numeric: false,
                              tooltip: "Asset Name",
                            ),
                            DataColumn(
                              label: Text(
                                'Asset Code',
                              ),
                              numeric: false,
                              tooltip: "Asset Code",
                            ),
                            DataColumn(
                              label: Text(
                                'Qty',
                              ),
                              numeric: true,
                              tooltip: "Qty",
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
                                  TextField(
                                    controller: _qtyController,
                                    // onChanged: (text) {
                                    //   print("Last text field: $text");
                                    //   user.lastName = text;
                                    // },
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