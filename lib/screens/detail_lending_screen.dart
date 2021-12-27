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

  String title;
  TextEditingController _borrowerController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _startController = TextEditingController();
  TextEditingController _endController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  Widget buildBorrowerField() {
    return TextFormField(
      enabled: false,
      controller: _borrowerController..text = widget.asset['borrower'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Borrower',
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

  Widget buildQtyField() {
    return TextFormField(
      enabled: false,
      controller: _qtyController..text = widget.asset['qty'].toString(),
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
          return 'Name of Asset is Required.';
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
      enabled: false,
      controller: _descriptionController..text = widget.asset['description'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Reason',
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

  Widget buildDateField() {
    return TextFormField(
      enabled: false,
      controller: _dateController..text = widget.asset['date'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Date Borrowed',
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

  Widget buildStartField() {
    return TextFormField(
      enabled: false,
      controller: _startController..text = widget.asset['time_start'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Start At',
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

  Widget buildEndField() {
    return TextFormField(
      enabled: false,
      controller: _endController..text = widget.asset['time_end'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'End At',
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

  Widget buildStatusField() {
    return TextFormField(
      enabled: false,
      controller: _statusController..text = widget.asset['status'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Status',
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

  String url = 'http://192.168.0.6:8000/api/lending';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.6:8000/api/lending/" + assetId;
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  Future updateLending(String assetId) async {
    String url = "http://192.168.0.6:8000/api/lending/" + assetId;
    var response = await http.put(Uri.parse(url));
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
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Lending Detail', style: TextStyle(color: Colors.black)),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FittedBox(
                child: Image.network(
                  widget.asset['image'],
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
                      widget.asset['product_code'],
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    buildBorrowerField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildQtyField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildDescriptionField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildDateField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildStartField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildEndField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    buildStatusField(),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      color: Colors.black54,
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      onPressed: () {
                        updateLending(widget.asset['id'].toString()).then((value) {
                          setState(() {});
                        });
                        Navigator.push(
                            context, MaterialPageRoute(
                          builder: (context)=>LendingScreen(),
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