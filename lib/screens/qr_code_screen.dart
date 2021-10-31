import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var list = [];
  Barcode result;
  QRViewController controller;
  DateTime lastScan;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  List<String> bitems = [];
  final TextEditingController eCtrl = new TextEditingController();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  getResult(result){
    if(result == null || result == result.code){
      return;
    } else {
      return result.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.check),
        onPressed: (){},
      ),
      body: Column(
        children: <Widget>[
          Container(height: 350, child: _buildQrView(context)),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RawMaterialButton(
                          elevation: 2.0,
                          fillColor: Color(0xFFF5CEB8),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Icon(Icons.flare_sharp);
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RawMaterialButton(
                          elevation: 2.0,
                          fillColor: Color(0xFFF5CEB8),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: Icon(Icons.pause),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: RawMaterialButton(
                          elevation: 2.0,
                          fillColor: Color(0xFFF5CEB8),
                          padding: EdgeInsets.all(10.0),
                          shape: CircleBorder(),
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: Icon(Icons.play_arrow),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (BuildContext, context){
                      return Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          height: 50,
                          width: 400,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Barcode Type: ${describeEnum(result.format)}   Data: ${getResult(result)}'),
                                  Icon(Icons.cancel_outlined),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 300 ||
        MediaQuery.of(context).size.height < 300)
        ? 100.0
        : 250.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      final currentScan = DateTime.now();
      if (lastScan == null || currentScan.difference(lastScan) > const Duration(seconds: 1)) {
        setState(() {
          lastScan = currentScan;
          result = scanData;
          list.add(result);
          // controller.pauseCamera();
        });
      }
      // setState(() {
      //   result = scanData;
      //   list.add(result);
      //   // controller.pauseCamera();
      // });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}