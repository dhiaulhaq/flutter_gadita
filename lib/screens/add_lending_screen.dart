import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/lending_screen.dart';
import 'package:http/http.dart' as http;

class AddLendingScreen extends StatelessWidget{

  final Text text;
  AddLendingScreen({this.text});
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _assetController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeStartController = TextEditingController();
  TextEditingController _timeEndController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _statusController = TextEditingController();

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.8:8000/api/lending"),
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
        title: Text('Add Lending'),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>LendingScreen(),
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
                  return "Please enter Lender Name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _assetController,
              decoration: InputDecoration(labelText: "Asset"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Reason"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter a reason";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: "Date"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the date";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeStartController,
              decoration: InputDecoration(labelText: "Time Start"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter starting time";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _timeEndController,
              decoration: InputDecoration(labelText: "Time End"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter ending time";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter phone number";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _statusController,
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
                  saveProduct().then((value) {
                    count++;
                    print(count);
                    historyList
                        .add(History(data: _nameController.text, dateTime: DateTime.now()));
                    Navigator.pop(
                        context, MaterialPageRoute(
                      builder: (context)=>LendingScreen(),
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