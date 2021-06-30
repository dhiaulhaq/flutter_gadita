import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:http/http.dart' as http;

class EditAssetScreen extends StatelessWidget{

  final Map asset;

  EditAssetScreen({@required this.asset});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.6:8000/api/products/" + asset['id'].toString()),
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
        title: Text('Edit Asset'),
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
              controller: _descriptionController..text = asset['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController..text = asset['price'],
              decoration: InputDecoration(labelText: "Price"),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter asset price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageUrlController..text = asset['image_url'],
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
                  updateProduct().then((value) {
                    Navigator.push(
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