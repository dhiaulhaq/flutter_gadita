import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/supplier_screen.dart';
import 'package:http/http.dart' as http;

class AddSupplierScreen extends StatelessWidget{

  final Text text;
  AddSupplierScreen({this.text});

  String title;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name of Supplier',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of Supplier is Required.';
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

  Widget buildAddressField() {
    return TextFormField(
      controller: _addressController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Address',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required.';
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
      keyboardType: TextInputType.phone,
      controller: _phoneController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone Number',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required.';
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
    await http.post(Uri.parse("http://192.168.0.6:8000/api/supplier"),
        body: {
          "name" : _nameController.text,
          "description" : _descriptionController.text,
          "address" : _addressController.text,
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
        title: Text('Add Supplier', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>SupplierScreen(),
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
                  'Add Supplier Form',
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
                buildAddressField(),
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
                    'Save',
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
                        builder: (context)=>SupplierScreen(),
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