import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadita/screens/barcode_create_screen.dart';
import 'package:gadita/screens/barcode_scan_screen.dart';
import 'package:gadita/widgets/button_barcode.dart';

class BarcodeScreen extends StatefulWidget {
  // final String title;
  //
  // const BarcodeScreen({
  //   @required this.title,
  // });

  @override
  _BarcodeScreen createState() => _BarcodeScreen();
}

class _BarcodeScreen extends State<BarcodeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Stock Opname"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonBarcode(
            text: 'Create',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BarcodeCreate(),
            )),
          ),
          const SizedBox(height: 32),
          ButtonBarcode(
            text: 'Scan Barcode',
            onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => BarcodeScanPage(),
            )),
          ),
        ],
      ),
    ),
  );
}