import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:http/http.dart' as http;

class EditCategoryScreen extends StatefulWidget{

  final Map asset;

  EditCategoryScreen({@required this.asset});

  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  String title;

  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _codeController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController..text = widget.asset['name'],
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
      controller: _codeController..text = widget.asset['code'],
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

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.6:8000/api/category/" + widget.asset['id'].toString()),
        body: {
          "name" : _nameController.text,
          "code" : _codeController.text,
        }
    );

    return json.decode(response.body);
  }

  Future deleteAssets() async {
    String url = "http://192.168.0.6:8000/api/category/" + widget.asset['id'].toString();
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm delete?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                deleteAssets().then((value) {
                  setState(() {});
                });
                Navigator.push(
                    context, MaterialPageRoute(
                  builder: (context)=>CategoryScreen(),
                ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Edit Category', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _showMyDialog();
                },
                child: Icon(
                  Icons.delete,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Edit Category Form',
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
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    updateProduct().then((value) {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context)=>CategoryScreen()));
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