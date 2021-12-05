import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/add_category_screen.dart';
import 'package:gadita/screens/add_supplier.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/edit_category_screen.dart';
import 'package:gadita/screens/supplier_detail_screen.dart';
import 'package:http/http.dart' as http;

class CategoryScreen extends StatefulWidget{

  final Map asset;
  CategoryScreen({@required this.asset});

  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<CategoryScreen> {
  String url = 'http://192.168.0.7:8000/api/category';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.7:8000/api/category/" + assetId;
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
                deleteAssets(widget.asset['id'].toString()).then((value) {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>AddCategoryScreen(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Category'),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>HomeScreen(),
          )),
        ),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index){
                  return Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]['name'] + ' (' + snapshot.data['data'][index]['code'] + ')',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () => _showMyDialog(),
                                        child: Icon(
                                          Icons.delete,
                                          size: 26.0,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context)=>EditCategoryScreen(asset: snapshot.data['data'][index],)
                                          ));
                                        },
                                        child: Icon(Icons.edit),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
            );
          }else{
            return Text('Loading...');
          }
        },
      ),
    );
  }
}