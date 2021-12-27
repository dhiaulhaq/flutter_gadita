import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/main.dart';
import 'package:gadita/model/period.dart';
import 'package:gadita/screens/add_asset_screen.dart';
import 'package:gadita/screens/assets_detail_screen.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:gadita/screens/compare_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/stock_opname_detail_screen.dart';
import 'package:gadita/screens/stock_opname_scan_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class StockOpnameScreen extends StatefulWidget{

  @override
  _StockOpnameScreenState createState() => _StockOpnameScreenState();
}

class _StockOpnameScreenState extends State<StockOpnameScreen> {
  var logger = Logger();
  final formatPeriod = new DateFormat('dd-MM-yyyy');
  final formatDay = new DateFormat('E');
  final formatMonth = new DateFormat('MMM');
  final formatYear = new DateFormat('yyyy');
  String url = 'http://192.168.0.6:8000/api/stock_opname';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future savePeriod() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/stock_opname/create"),
      body: {
        "period" : formatPeriod.format(new DateTime.now()),
        "year" : formatYear.format(new DateTime.now()),
        "month" : formatMonth.format(new DateTime.now()),
        "day" : formatDay.format(new DateTime.now()),
      },
    );

    logger.d('${response.body}');

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Start new period?'),
                content: Text(
                  'Period Date: '+formatDay.format(new DateTime.now())+', '+formatPeriod.format(new DateTime.now()),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No', style: TextStyle(color: Colors.grey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: (){
                      savePeriod();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context){
                          return StockOpnameScreen();
                        }),
                      );
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context)=>StockOpnameScan(idPeriod: period,)
                      //     ), (route) => false
                      // );
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Stock Opname', style: TextStyle(color: Colors.black)),
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
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                    builder: (context)=>CompareScreen(),
                  ));
                },
                child: Icon(
                  Icons.bar_chart,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index){
                  return Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=>StockOpnameDetail(period: snapshot.data['data'][index],)
                        ));
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Period: '+snapshot.data['data'][index]['day']+', '+snapshot.data['data'][index]['period'],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            // Navigator.push(
                                            //     context, MaterialPageRoute(
                                            //     builder: (context)=>EditAssetScreen(asset: snapshot.data['data'][index],)
                                            // ));
                                          },
                                          child: Icon(Icons.keyboard_arrow_right),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
          }else{
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
          }
        },
      ),
    );
  }
}