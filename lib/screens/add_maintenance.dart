import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/maintenance_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddMaintenanceScreen extends StatefulWidget{

  final Text text;
  AddMaintenanceScreen({this.text});

  @override
  _AddMaintenanceScreenState createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  String title;
  DateTime date;
  String strDate;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('hello $picked');
      setState(() {
        date = picked;
      });
    }
  }

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController,
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
      controller: _descriptionController,
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
      controller: _locationController,
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
      controller: _addressController,
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
      controller: _dateController,
      onTap: () async {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        // Show Date Picker Here
        await _selectDate(context);
        _dateController.text = DateFormat('dd/MM/yyyy').format(date);
        //setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Borrow Date',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        print('date:: ${date.toString()}');
        if (value.isEmpty) {
          return 'Borrow Date is Required.';
        }
        return null;
      },
      onSaved: (String val) {
        strDate = val;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _phoneController,
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

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/maintenance"),
        body: {
          "name" : _nameController.text,
          "description" : _descriptionController.text,
          "location" : _locationController.text,
          "address" : _addressController.text,
          "date" : _dateController.text,
          "phone" : _phoneController.text,
        }
    );

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Maintenance', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>MaintenanceScreen(),
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Add Maintenance Form',
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
                RaisedButton(
                  color: Colors.black54,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    saveProduct().then((value) {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context)=>MaintenanceScreen(),
                      ));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}