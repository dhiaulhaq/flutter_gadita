import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:http/http.dart' as http;

class AddCategoryScreen extends StatelessWidget{

  final Text text;
  AddCategoryScreen({this.text});
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.2:8000/api/category"),
        body: {
          "name" : _nameController.text,
          "code" : _codeController.text,
        }
    );

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Category'),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>CategoryScreen(),
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
                  return "Please enter category name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(labelText: "Code"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter category code";
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
                    Navigator.push(
                        context, MaterialPageRoute(
                      builder: (context)=>CategoryScreen(),
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