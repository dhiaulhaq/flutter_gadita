import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/barcode_detail_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:gadita/screens/lending_history_screen.dart';
import 'package:http/http.dart' as http;

import 'add_lending_screen.dart';

class AssetsDetailScreen extends StatefulWidget{

  final Map asset;
  AssetsDetailScreen({@required this.asset});

  @override
  _AssetsDetailScreenState createState() => _AssetsDetailScreenState();
}

class _AssetsDetailScreenState extends State<AssetsDetailScreen> {

  String title;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _availableController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      enabled: false,
      controller: _nameController..text = widget.asset['name'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name of Asset',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of Asset is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildCategoryField() {
    return TextFormField(
      enabled: false,
      controller: _categoryController..text = widget.asset['product_code'],
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Category',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildQtyField() {
    return TextFormField(
      enabled: false,
      keyboardType: TextInputType.number,
      controller: _qtyController..text = widget.asset['qty_master'].toString(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Qty',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Qty is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildAvailableField() {
    return TextFormField(
      enabled: false,
      keyboardType: TextInputType.number,
      controller: _availableController..text = widget.asset['qty_master'].toString(),
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Available',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Available is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      maxLines: null,
      enabled: false,
      controller: _descriptionController..text = widget.asset['description'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  String url = 'http://192.168.0.6:8000/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.6:8000/api/products/" + assetId;
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
            builder: (context)=>EditAssetScreen(
                idAsset: widget.asset['id'],
                nameAsset: widget.asset['name'],
                codeAsset: widget.asset['product_code'],
                qtyAsset:widget.asset['qty_master'],
                descAsset:widget.asset['description'],
                imgAsset:widget.asset['image_url'],
            ),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Asset Detail', style: TextStyle(color: Colors.black)),
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
                    builder: (context)=>LendingHistoryScreen(idProduct: widget.asset['id']),
                  ));
                },
                child: Icon(
                  Icons.history,
                  size: 26.0,
                ),
              )
          ),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context)=>BarcodeDetailScreen(assetBarcode: widget.asset['product_code']),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FittedBox(
                child: Image.network(
                  widget.asset['image_url'],
                ),
                fit: BoxFit.fill,

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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Asset Code: " + widget.asset['product_code'].toString(),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    buildQtyField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    // buildAvailableField(),
                    // SizedBox(
                    //   height: 20.0,
                    // ),
                    buildDescriptionField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.black54,
                      child: Text(
                        'Lending',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(
                          builder: (context)=>AddLendingScreen(idProduct: widget.asset['id'], nameProduct: widget.asset['name'], codeProduct: widget.asset['product_code']),
                        ));
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}