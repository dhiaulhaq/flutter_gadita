import 'package:flutter/material.dart';
import 'package:gadita/constants.dart';
import 'package:gadita/screens/add_asset_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Recent Activities'),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      // body: ListView.builder(
      //   itemCount: historyList.length,
      //   itemBuilder: (BuildContext context, int index){
      //     return Center(
      //       child: Container(
      //         alignment: Alignment.topCenter,
      //         padding: new EdgeInsets.only(
      //             right: 20.0,
      //             left: 20.0),
      //         child: Container(
      //           margin: EdgeInsets.symmetric(vertical: 5),
      //           padding: EdgeInsets.all(10),
      //           height: 70,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(13),
      //             boxShadow: [
      //               BoxShadow(
      //                 offset: Offset(0, 17),
      //                 blurRadius: 23,
      //                 spreadRadius: -13,
      //                 color: kShadowColor,
      //               ),
      //             ],
      //           ),
      //           child: Row(
      //             children: <Widget>[
      //               Expanded(
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: <Widget>[
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           "Admin add",
      //                           style: Theme.of(context).textTheme.subtitle2,
      //                         ),
      //                         Padding(
      //                           padding: EdgeInsets.all(1),
      //                         ),
      //                         Text(
      //                           "${historyList[index].data}",
      //                           style: Theme.of(context).textTheme.subtitle2,
      //                         ),
      //                       ],
      //                     ),
      //                     Row(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: <Widget>[
      //                         Text(
      //                           "Date: ",
      //                           style: TextStyle(
      //                             fontStyle: FontStyle.italic,
      //                           ),
      //                         ),
      //                         Padding(
      //                           padding: EdgeInsets.all(1),
      //                         ),
      //                         Text(
      //                           "${historyList[index].dateTime.day.toString()}"+"-"+"${historyList[index].dateTime.month.toString()}"+"-"+"${historyList[index].dateTime.year.toString()}",
      //                           style: TextStyle(
      //                             fontStyle: FontStyle.italic,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: EdgeInsets.all(10),
      //                 child: Text(
      //                   "${historyList[index].dateTime.hour.toString()}"+":""${historyList[index].dateTime.minute.toString()}",
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // )
    );
  }
}