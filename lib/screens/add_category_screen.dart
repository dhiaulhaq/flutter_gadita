import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:http/http.dart' as http;

class AddCategoryScreen extends StatelessWidget{

  final Text text;
  AddCategoryScreen({this.text});

  String title;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _codeController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name of Category',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of Category is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildCodeField() {
    return TextFormField(
      controller: _codeController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Code of Category',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Code of Category is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/category"),
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
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Category', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Add Category Form',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildNameField(),
                SizedBox(
                  height: 20.0,
                ),
                buildCodeField(),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.black54,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    saveProduct().then((value) {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context)=>CategoryScreen(),
                      ));
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