import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/supplier_screen.dart';
import 'package:http/http.dart' as http;

class EditSupplierScreen extends StatelessWidget{

  final Map asset;

  EditSupplierScreen({@required this.asset});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.7:8000/api/supplier/" + asset['id'].toString()),
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
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Edit Supplier'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = asset['name'],
              decoration: InputDecoration(labelText: "Name"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter supplier name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController..text = asset['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter supplier description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController..text = asset['address'],
              decoration: InputDecoration(labelText: "Address"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter supplier address";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController..text = asset['phone'],
              decoration: InputDecoration(labelText: "Phone Number"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter supplier phone number";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: (){
                if(_formKey.currentState.validate()){
                  updateProduct().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>SupplierScreen()));
                  });
                }
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}