import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/barcode_detail_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:http/http.dart' as http;

class AssetsDetailScreen extends StatefulWidget{

  final Map asset;
  AssetsDetailScreen({@required this.asset});

  @override
  _AssetsDetailScreenState createState() => _AssetsDetailScreenState();
}

class _AssetsDetailScreenState extends State<AssetsDetailScreen> {
  String url = 'http://192.168.0.2:8000/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.2:8000/api/products/" + assetId;
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
                  builder: (context)=>AssetsScreen(),
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
        title: Text('Asset Detail'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>BarcodeDetailScreen(assetBarcode: widget.asset['id']),
                  ));
                },
                child: Icon(
                  Icons.qr_code,
                  size: 26.0,
                ),
              )
          ),
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.black,
            ),
            padding: EdgeInsets.all(5),
            height: 250,
            width: 250,
            child: Image.network(
              widget.asset['image_url'],
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.asset['name'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Price:",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Asset Code: " + widget.asset['id'].toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Rp. " + widget.asset['price'],
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Description:",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
            child: Text(
              widget.asset['description'],
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}