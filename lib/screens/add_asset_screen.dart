import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AddAssetScreen extends StatefulWidget {

  @override
  _AddAssetState createState() => _AddAssetState();

}

class _AddAssetState extends State<AddAssetScreen> {
  var logger = Logger();

  String title;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name of Asset',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of Asset is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildCategoryField() {
    return TextFormField(
      controller: _categoryController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Category',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Category is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Description',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildQtyField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _qtyController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Qty',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Qty is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildImageField() {
    return TextFormField(
      controller: _imageUrlController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Image',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Image is Required.';
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
      await http.post(Uri.parse("http://192.168.0.6:8000/api/products"),
        body: {
          "name" : _nameController.text,
          "category_id" : _categoryController.text,
          "description" : _descriptionController.text,
          "qty_master" : _qtyController.text,
          "image_url" : _imageUrlController.text,
        }
      );

    logger.d('${response.body}');

    return json.decode(response.body);
  }

  String _baseUrl = "http://192.168.0.6:8000/api/category";
  String _valCategory;
  List<dynamic> _dataCategory = List();
  void getCategory() async {
    final respose = await http.get(_baseUrl + "getCategory1"); //untuk melakukan request ke webservice
    var listData = jsonDecode(respose.body); //lalu kita decode hasil datanya
    setState(() {
      _dataCategory = listData; // dan kita set kedalam variable _dataProvince
    });
    print("data : $listData");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory(); //Ketika pertama kali membuka home screen makan method ini dijalankan untuk pertama kalinya juga
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Asset', style: TextStyle(color: Colors.black)),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Add Asset Form',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildNameField(),
                SizedBox(
                  height: 20.0,
                ),
                buildCategoryField(),
                SizedBox(
                  height: 20.0,
                ),
                buildDescriptionField(),
                SizedBox(
                  height: 20.0,
                ),
                buildQtyField(),
                SizedBox(
                  height: 20.0,
                ),
                buildImageField(),
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
                        context,
                        MaterialPageRoute(builder: (context){
                          return AssetsScreen();
                        }),
                      );
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