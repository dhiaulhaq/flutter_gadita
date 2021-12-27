import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class BarcodeCreate extends StatefulWidget {
  @override
  _BarcodeCreate createState() => _BarcodeCreate();
}

class _BarcodeCreate extends State<BarcodeCreate> {
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
      title: Text("Create Barcode", style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.file_download),
          onPressed: _captureAndSharePng,
        )
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
                      barcode: Barcode.code39(),
                      data: controller.text ?? 'Hello World',
                      width: 400,
                      height: 160,
                      drawText: false,
                    ),
                    SizedBox(height: 10),
                    Text(
                      controller.text,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: buildTextField(context)),
                const SizedBox(width: 12),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.done, size: 30),
                  onPressed: () => setState(() {
                    print(controller.text);
                  }),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Widget buildTextField(BuildContext context) => TextField(
    controller: controller,
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    decoration: InputDecoration(
      hintText: 'Enter the data',
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
    ),
  );
}