import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:http/http.dart' as http;

class EditCategoryScreen extends StatelessWidget{

  final Map asset;

  EditCategoryScreen({@required this.asset});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.2:8000/api/category/" + asset['id'].toString()),
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
        title: Text('Edit Category'),
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
                  return "Please enter category name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _codeController..text = asset['code'],
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
                  updateProduct().then((value) {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context)=>CategoryScreen()));
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