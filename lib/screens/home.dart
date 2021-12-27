import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/controller/api.dart';
import 'package:gadita/screens/login.dart';
import 'package:gadita/screens/stock_opname_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:gadita/constants.dart';
import 'package:gadita/screens/activities_screen.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/lending_screen.dart';
import 'package:gadita/screens/maintenance_screen.dart';
import 'package:gadita/screens/management_screen.dart';
import 'package:gadita/screens/stock_opname_scan_screen.dart';
import 'package:gadita/screens/supplier_screen.dart';
import 'package:gadita/widgets/bottom_nav_bar.dart';
import 'package:gadita/widgets/search_bar.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//
//   runApp(MyApp());
// }

// class Home extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'GADITA',
//       theme: ThemeData(
//         fontFamily: "Cairo",
//         scaffoldBackgroundColor: kBackgroundColor,
//         textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

class HomeScreen extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen>{
  String name;
  @override
  void initState(){
    _loadUserData();
    super.initState();
  }
  _loadUserData() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));

    if(user != null) {
      setState(() {
        name = user['fname'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //Give total height & width of device
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            //Height of the container is 45% of total height
            height: size.height * .30,
            decoration: BoxDecoration(
              color: Color(0xFFF5CEB8),
              // color: Colors.orange,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .10,
                right: 20.0,
                left: 20.0),
            child: Text(
              "GADITA",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .22,
                right: 20.0,
                left: 20.0),
            child: new Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              child: new Card(
                color: Colors.white,
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(left: 20.0),
                        //   child: SvgPicture.asset(
                        //       "assets/icons/user1.svg"
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            "$name",
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: ()=> logout(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .40,
                right: 20.0,
                left: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new SizedBox(height: 20),
                new Container(
                  height: 105,
                  width: 105,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return AssetsScreen();
                              }),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.list,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context){
                                        return AssetsScreen();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Assets'),
                    ],
                  ),
                ),
                new Container(
                  height: 105,
                  width: 105,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return LendingScreen();
                              }),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.widgets_outlined,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context){
                                        return LendingScreen();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                      SizedBox(height: 10),
                      Text('Lending'),
                    ],
                  ),
                ),
                new Container(
                  height: 105,
                  width: 105,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: IconButton(
                                icon: Icon(
                                  Icons.people,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return SupplierScreen();
                                    }),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Supplier'),
                    ],
                  ),
                ),
                new SizedBox(height: 20),
              ],
            ),
          ),
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .60,
                right: 20.0,
                left: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new SizedBox(height: 20),
                new Container(
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return MaintenanceScreen();
                              }),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.build_sharp,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context){
                                        return MaintenanceScreen();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("Maintenance")
                    ],
                  ),
                ),
                new Container(
                  height: 110,
                  width: 110,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return StockOpnameScreen();
                              }),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.qr_code_scanner,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context){
                                        return StockOpnameScreen();
                                      }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                      ),
                      SizedBox(height: 10),
                      Text('Stock Opname'),
                    ],
                  ),
                ),
                new SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void logout() async{
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=>Login()));
    }
  }
}
