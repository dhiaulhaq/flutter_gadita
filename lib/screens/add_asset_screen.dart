import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:http/http.dart' as http;

class AddAssetScreen extends StatefulWidget {

  @override
  _AddAssetState createState() => _AddAssetState();

}

class _AddAssetState extends State<AddAssetScreen> {

  // final Text text;
  // AddAssetScreen({this.text});
  int count = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageUrlController = TextEditingController();

  Future saveProduct() async{
    final response =
      await http.post(Uri.parse("http://192.168.0.2:8000/api/products"),
        body: {
          "name" : _nameController.text,
          "description" : _descriptionController.text,
          "price" : _priceController.text,
          "image_url" : _imageUrlController.text,
        }
      );

    return json.decode(response.body);
  }

  String category_id;
  List<String> category =[
    "Meja",
    "Bangku",
    "LCD",
    "Proyektor",
    "Papan Tulis"
  ];

  String _mySelection;
  final String category_url = "http://192.168.0.2:8000/api/category";
  List category_data = List();

  Future<String> getCategoryData() async {
    var res = await http
        .get(Uri.encodeFull(category_url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      category_data = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.getCategoryData();
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
            // DropDownField(
            //     onValueChanged: (dynamic value){
            //       category_id = value;
            //     },
            //   value: category_id,
            //   required: false,
            //   hintText: 'Choose a category',
            //   labelText: 'Category',
            //   items: category,
            // ),

              DropdownButton(
                items: category_data.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['name']),
                    value: item['id'].toString(),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    _mySelection = newVal;
                  });
                },
                value: _mySelection,
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