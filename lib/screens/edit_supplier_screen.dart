import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/supplier_screen.dart';
import 'package:http/http.dart' as http;

class EditSupplierScreen extends StatelessWidget{

  int id;
  String name, description, address, phone;
  EditSupplierScreen({@required this.id, this.name, this.description, this.address, this.phone});

  String title;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController..text = name,
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
      controller: _descriptionController..text = description,
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
      controller: _addressController..text = address,
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
      controller: _phoneController..text = phone,
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

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.6:8000/api/supplier/" + id.toString()),
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
        title: Text('Edit Supplier', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Edit Supplier Form',
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
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    updateProduct().then((value) {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>SupplierScreen()));
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