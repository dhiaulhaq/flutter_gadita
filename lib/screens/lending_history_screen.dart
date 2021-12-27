import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/main.dart';
import 'package:gadita/screens/add_asset_screen.dart';
import 'package:gadita/screens/assets_detail_screen.dart';
import 'package:gadita/screens/category_screen.dart';
import 'package:gadita/screens/edit_asset_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:http/http.dart' as http;

class LendingHistoryScreen extends StatefulWidget{
  final int idProduct;
  LendingHistoryScreen({Key key, @required this.idProduct}) : super(key: key);

  @override
  _LendingHistoryScreenState createState() => _LendingHistoryScreenState(idProduct);
}

class _LendingHistoryScreenState extends State<LendingHistoryScreen> {
  int idProduct;
  _LendingHistoryScreenState(this.idProduct);

  Future getProducts() async {
    var response = await http.get(Uri.parse('http://192.168.0.6:8000/api/products/'+idProduct.toString()));
    // print(json.decode(response.body));
    return json.decode(response.body);
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
            builder: (context)=>AddAssetScreen(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Lending History', style: TextStyle(color: Colors.black)),
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
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data['time'].length,
                  itemBuilder: (context, index){
                    return Container(
                      child: Column(
                        children: [
                          Text(
                            snapshot.data['time'][index]['date'],
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Borrower: "+snapshot.data['time'][index]['borrower'],
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Phone: "+snapshot.data['time'][index]['phone'],
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 3,
                            height: 25,
                            color: Colors.black,
                          )
                        ],
                      ),
                    );
                  }
              );
            }else{
              return Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}