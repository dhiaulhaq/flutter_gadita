import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/maintenance_screen.dart';
import 'package:http/http.dart' as http;

class EditMaintenanceScreen extends StatelessWidget{

  final Map asset;

  EditMaintenanceScreen({@required this.asset});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.5:8000/api/maintenance/" + asset['id'].toString()),
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
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Edit Maintenance'),
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
                  return "Please enter name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController..text = asset['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController..text = asset['location'],
              decoration: InputDecoration(labelText: "Price"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter location";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController..text = asset['address'],
              decoration: InputDecoration(labelText: "Address"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter address";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController..text = asset['date'],
              decoration: InputDecoration(labelText: "Dare"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please date";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController..text = asset['phone'],
              decoration: InputDecoration(labelText: "Phone Number"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter phone number";
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
                    Navigator.pop(
                        context, MaterialPageRoute(
                        builder: (context)=>MaintenanceScreen()));
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