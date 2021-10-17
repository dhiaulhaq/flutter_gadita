import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/barcode_detail_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:gadita/screens/lending_screen.dart';
import 'package:http/http.dart' as http;

class LendingDetailScreen extends StatefulWidget{

  final Map asset;
  LendingDetailScreen({@required this.asset});

  @override
  _LendingDetailScreenState createState() => _LendingDetailScreenState();
}

class _LendingDetailScreenState extends State<LendingDetailScreen> {
  String url = 'http://192.168.0.5:8000/api/lending';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.5:8000/api/lending/" + assetId;
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
                deleteAssets(widget.asset['id'].toString()).then((value) {
                  setState(() {});
                });
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context)=>LendingScreen(),
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
        child: Icon(Icons.edit),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>EditAssetScreen(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Lending Detail'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.asset['name'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "ID: " + widget.asset['id'].toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Asset: " + widget.asset['asset'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Description: " + widget.asset['description'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Date: " + widget.asset['date'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Start at: " + widget.asset['time_start'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "End at: " + widget.asset['time_end'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Phone Number: " + widget.asset['phone'],
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Status: " + widget.asset['status'],
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "ID: " + widget.asset['id'].toString(),
          //         style: TextStyle(fontSize: 15),
          //       ),
          //       Text(
          //         "Asset: " + widget.asset['asset'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "Description: " + widget.asset['description'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "Date: " + widget.asset['date'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "Start at: " + widget.asset['time_start'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "End at: " + widget.asset['time_end'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "Phone Number: " + widget.asset['phone'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //       Text(
          //         "Status: " + widget.asset['status'],
          //         style: TextStyle(fontSize: 18),
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text(
          //         "Description:",
          //         style: TextStyle(fontSize: 15),
          //       ),
          //       Text(
          //         "",
          //       ),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
          //   child: Text(
          //     widget.asset['description'],
          //     style: TextStyle(fontSize: 15),
          //   ),
          // ),
        ],
      ),
    );
  }
}