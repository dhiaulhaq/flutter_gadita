import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadita/constants.dart';
import 'package:gadita/screens/activities_screen.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/barcode_screen.dart';
import 'package:gadita/screens/details_screen.dart';
import 'package:gadita/screens/management_screen.dart';
import 'package:gadita/screens/qr_code_screen.dart';
import 'package:gadita/widgets/bottom_nav_bar.dart';
import 'package:gadita/widgets/category_card.dart';
import 'package:gadita/widgets/search_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GADITA',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; //Give total height & width of device
    return Scaffold(
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
                            "Admin",
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
                        onPressed: ()=> exit(0),
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
                  height: 80,
                  width: 80,
                  child: Card(
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
                ),
                new Container(
                  height: 80,
                  width: 80,
                  child: Card(
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
                              return BarcodeScreen();
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
                                    return QRViewExample();
                                  }),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),
                ),
                new Container(
                  height: 80,
                  width: 80,
                  child: Card(
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
                              Icons.person,
                              color: Colors.black,
                              size: 30.0,
                            ),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return ManagementScreen();
                                }),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
            child: Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      "Recent Activities",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context){
                            return ActivitiesScreen();
                          }),
                        );
                      },
                      child: Text("See More"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          new Container(
            alignment: Alignment.topCenter,
            padding: new EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .65,
                right: 20.0,
                left: 20.0),
            child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 23,
                              spreadRadius: -13,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Admin",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "change yada yada",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "02-03-2021",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "19:25",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 23,
                              spreadRadius: -13,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Admin",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "change yada yada",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "02-03-2021",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "19:25",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 23,
                              spreadRadius: -13,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Admin",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "change yada yada",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "02-03-2021",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "19:25",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 23,
                              spreadRadius: -13,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Admin",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "change yada yada",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "02-03-2021",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "19:25",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.all(10),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 17),
                              blurRadius: 23,
                              spreadRadius: -13,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Admin",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "change yada yada",
                                        style: Theme.of(context).textTheme.subtitle2,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Date: ",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1),
                                      ),
                                      Text(
                                        "02-03-2021",
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "19:25",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            ),
          ),

          //Previous Body Part
          // SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: <Widget>[
          //         Align(
          //           alignment: Alignment.topRight,
          //           child: InkWell(
          //             child: Container(
          //               alignment: Alignment.center,
          //               height: 52,
          //               width: 52,
          //               decoration: BoxDecoration(
          //                 color: Color(0xFFF2BEA1),
          //                 shape: BoxShape.circle,
          //               ),
          //               child: SvgPicture.asset("assets/icons/menu.svg"),
          //             ),
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(builder: (context){
          //                   return BarcodeScreen();
          //                 }),
          //               );
          //             },
          //           ),
          //         ),
          //         Text(
          //           "Good Morning \nNaufal",
          //           style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w900),
          //         ),
          //         // SearchBar(),
          //         Expanded(
          //           child: GridView.count(
          //             crossAxisCount: 2,
          //             childAspectRatio: .85,
          //             crossAxisSpacing: 20,
          //             mainAxisSpacing: 20,
          //             children: <Widget>[
          //               CategoryCard(
          //                 title: "Assets",
          //                 svgSrc: "assets/icons/Hamburger.svg",
          //                 press: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(builder: (context){
          //                       return AssetsScreen();
          //                     }),
          //                   );
          //                 },
          //               ),
          //               CategoryCard(
          //                 title: "Kegel Exercises",
          //                 svgSrc: "assets/icons/Excrecises.svg",
          //                 press: () {},
          //               ),
          //               CategoryCard(
          //                 title: "Meditation",
          //                 svgSrc: "assets/icons/Meditation.svg",
          //                 press: () {
          //                   Navigator.push(
          //                     context,
          //                     MaterialPageRoute(builder: (context){
          //                       return DetailsScreen();
          //                     }),
          //                   );
          //                 },
          //               ),
          //               CategoryCard(
          //                 title: "Yoga",
          //                 svgSrc: "assets/icons/yoga.svg",
          //                 press: () {},
          //               ),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
