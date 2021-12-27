import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:http/http.dart' as http;

class EditAssetScreen extends StatefulWidget{

  final int idAsset, qtyAsset;
  final String nameAsset, codeAsset, descAsset, imgAsset;
  EditAssetScreen({
    Key key,
    @required this.idAsset,
    @required this.nameAsset,
    @required this.codeAsset,
    @required this.qtyAsset,
    @required this.descAsset,
    @required this.imgAsset,
  }) : super(key: key);

  @override
  _EditAssetScreenState createState() => _EditAssetScreenState(
      idAsset, nameAsset, codeAsset, qtyAsset, descAsset, imgAsset,
  );
}

class _EditAssetScreenState extends State<EditAssetScreen> {
  int idAsset, qtyAsset;
  String nameAsset, codeAsset, descAsset, imgAsset;
  _EditAssetScreenState(
      this.idAsset,
      this.nameAsset,
      this.codeAsset,
      this.qtyAsset,
      this.descAsset,
      this.imgAsset,
      );

  String title;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Widget buildNameField() {
    return TextFormField(
      controller: _nameController..text = nameAsset,
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
      enabled: false,
      controller: _categoryController..text = codeAsset,
      style: TextStyle(color: Colors.grey),
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
      controller: _descriptionController..text = descAsset,
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
      controller: _qtyController..text = qtyAsset.toString(),
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
      controller: _imageUrlController..text = imgAsset,
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

  Future updateProduct() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.6:8000/api/products/" + idAsset.toString()),
        body: {
          "name" : _nameController.text,
          "description" : _descriptionController.text,
          "qty_master" : _qtyController.text,
          "image_url" : _imageUrlController.text,
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
        title: Text('Edit Asset', style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Edit Asset Form',
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
                          builder: (context)=>AssetsScreen()));
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