import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/maintenance_screen.dart';
import 'package:http/http.dart' as http;

class AddMaintenanceScreen extends StatelessWidget{

  final Text text;
  AddMaintenanceScreen({this.text});
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.8:8000/api/maintenance"),
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
        title: Text('Add Maintenance'),
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
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: "Location"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter location";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(labelText: "Address"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter address";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: "Date"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter date";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter phone";
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
                  saveProduct().then((value) {
                    count++;
                    print(count);
                    historyList
                        .add(History(data: _nameController.text, dateTime: DateTime.now()));
                    Navigator.pop(
                        context, MaterialPageRoute(
                      builder: (context)=>MaintenanceScreen(),
                    ));
                  });
                }
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}

int count = 0;
List<History> historyList = [];

class History{
  String data;
  DateTime dateTime;

  History({this.data, this.dateTime});
}