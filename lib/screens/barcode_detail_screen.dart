import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BarcodeDetailScreen extends StatefulWidget {
  final String assetBarcode;
  BarcodeDetailScreen({Key key, @required this.assetBarcode}) : super(key: key);

  @override
  _BarcodeDetailScreen createState() => _BarcodeDetailScreen(assetBarcode);
}

class _BarcodeDetailScreen extends State<BarcodeDetailScreen> {
  String assetBarcode;
  _BarcodeDetailScreen(this.assetBarcode);
  final controller = TextEditingController();
  GlobalKey globalKey = new GlobalKey();

  Future<void> _captureAndSharePng() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final directory = (await getApplicationDocumentsDirectory()).path;
      print(pngBytes);
      File imgFile = new File('$directory/barcode.png');
      imgFile.writeAsBytes(pngBytes);

      // final tempDir = await getTemporaryDirectory();
      // final file = await new File('${tempDir.path}/image.png').create();
      // await file.writeAsBytes(pngBytes);
      //
      // final channel = const MethodChannel('channel:me.naufal.share/share');
      // channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Color(0xFFF5CEB8),
      title: Text("Asset Barcode", style: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      actions: <Widget>[
        // IconButton(
        //   icon: Icon(Icons.file_download),
        //   onPressed: _captureAndSharePng,
        // )
      ],
    ),
    body: Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Container(
                // color: Colors.white,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: <Widget>[
                    BarcodeWidget(
                      barcode: Barcode.qrCode(),
                      data: assetBarcode,
                      width: 400,
                      height: 160,
                      drawText: false,
                    ),
                    SizedBox(height: 10),
                    Text(
                      assetBarcode,
                      style: TextStyle(fontSize: 20),
                    ),
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