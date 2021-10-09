import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:http/http.dart' as http;

class EditLendingScreen extends StatelessWidget{

  final Map asset;

  EditLendingScreen({@required this.asset});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _assetController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeStartController = TextEditingController();
  TextEditingController _timeEndController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.8:8000/api/lending/" + asset['id'].toString()),
        body: {
          "name" : _nameController.text,
          "asset" : _assetController.text,
          "description" : _descriptionController.text,
          "date" : _dateController.text,
          "time_start" : _timeStartController.text,
          "time_end" : _timeEndController.text,
          "phone" : _phoneController.text,
          "status" : _statusController.text,
        }
    );

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Edit Lending'),
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
                  return "Please enter asset name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _assetController..text = asset['asset'],
              decoration: InputDecoration(labelText: "Asset"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset name";
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
              controller: _dateController..text = asset['date'],
              decoration: InputDecoration(labelText: "Dat"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter date";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeStartController..text = asset['time_start'],
              decoration: InputDecoration(labelText: "Start at"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter Starting Time";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeEndController..text = asset['time_end'],
              decoration: InputDecoration(labelText: "End Time"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter end time";
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
            TextFormField(
              controller: _statusController..text = asset['status'],
              decoration: InputDecoration(labelText: "Status"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter status";
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
                        builder: (context)=>AssetsScreen()));
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