import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/barcode_detail_screen.dart';
import 'package:gadita/screens/edit_maintenance_screen.dart';
import 'package:gadita/screens/maintenance_screen.dart';
import 'package:http/http.dart' as http;

class MaintenanceDetailScreen extends StatefulWidget{

  final Map asset;
  MaintenanceDetailScreen({@required this.asset});

  @override
  _MaintenanceDetailScreenState createState() => _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends State<MaintenanceDetailScreen> {

  String title;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

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

  Widget buildDescriptionField() {
    return TextFormField(
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

  Widget buildLocationField() {
    return TextFormField(
      enabled: false,
      controller: _locationController..text = widget.asset['location'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Location',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildAddressField() {
    return TextFormField(
      enabled: false,
      controller: _addressController..text = widget.asset['address'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Address of Maintenance',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address of Maintenance is Required.';
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
        labelText: 'Date',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Date is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      enabled: false,
      keyboardType: TextInputType.phone,
      controller: _phoneController..text = widget.asset['phone'],
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  String url = 'http://192.168.0.6:8000/api/maintenance';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.6:8000/api/maintenance/" + assetId;
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
                  builder: (context)=>MaintenanceScreen(),
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
            builder: (context)=>EditMaintenanceScreen(
                id: widget.asset['id'],
                name: widget.asset['name'],
                description: widget.asset['description'],
                location: widget.asset['location'],
                address: widget.asset['address'],
                dateM: widget.asset['date'],
                phone: widget.asset['phone'],
            ),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Maintenance Detail', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text(
                  'Maintenance',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildNameField(),
                SizedBox(
                  height: 20.0,
                ),
                buildDescriptionField(),
                SizedBox(
                  height: 20.0,
                ),
                buildLocationField(),
                SizedBox(
                  height: 20.0,
                ),
                buildAddressField(),
                SizedBox(
                  height: 20.0,
                ),
                buildDateField(),
                SizedBox(
                  height: 20.0,
                ),
                buildPhoneField(),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}