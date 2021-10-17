import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/main.dart';
import 'package:gadita/screens/add_maintenance.dart';
import 'package:gadita/screens/edit_maintenance_screen.dart';
import 'package:gadita/screens/home.dart';
import 'package:gadita/screens/maintenance_detail_screen.dart';
import 'package:http/http.dart' as http;

class MaintenanceScreen extends StatefulWidget{

  @override
  _MaintenanceScreenState createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  String url = 'http://192.168.0.5:8000/api/maintenance';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteAssets(String assetId) async {
    String url = "http://192.168.0.5:8000/api/maintenance/" + assetId;
    var response = await http.delete(Uri.parse(url));
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
            builder: (context)=>AddMaintenanceScreen(),
          ));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Maintenance'),
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
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context)=>MaintenanceDetailScreen(asset: snapshot.data['data'][index],)
                        ));
                      },
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
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data['data'][index]['name'],
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                    context, MaterialPageRoute(
                                                    builder: (context)=>EditMaintenanceScreen(asset: snapshot.data['data'][index],)
                                                ));
                                              },
                                              child: Icon(Icons.edit),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(snapshot.data['data'][index]['description']),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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