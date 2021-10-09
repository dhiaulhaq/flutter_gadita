import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:http/http.dart' as http;

class AddAssetScreen extends StatelessWidget{

  final Text text;
  AddAssetScreen({this.text});
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future saveProduct() async{
    final response =
      await http.post(Uri.parse("http://192.168.0.8:8000/api/products"),
        body: {
          "name" : _nameController.text,
          "description" : _descriptionController.text,
          "price" : _priceController.text,
          "image_url" : _imageUrlController.text,
        }
      );

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Asset'),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>AssetsScreen(),
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
                  return "Please enter asset name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: "Description"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(labelText: "Price"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: "Image URL"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset image url";
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
                        builder: (context)=>AssetsScreen(),
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