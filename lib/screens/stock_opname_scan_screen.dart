import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/stock_opname_result_screen.dart';
import 'package:logger/logger.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class StockOpnameScan extends StatefulWidget {

  final Map asset;
  final int idPeriod;
  StockOpnameScan({Key key, @required this.idPeriod, @required this.asset}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StockOpnameScanState(idPeriod);
}

class _StockOpnameScanState extends State<StockOpnameScan> {
  int idPeriod;
  _StockOpnameScanState(this.idPeriod);

  var logger = Logger();
  Barcode result;
  QRViewController controller;
  DateTime lastScan;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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
      if (lastScan == null || currentScan.difference(lastScan) > const Duration(seconds: 3)) {
        setState(() {
          lastScan = currentScan;
          result = scanData;
          item.add(getResult(result));
        });
      }
    });
  }

  getResult(result){
    if(result == null || result == result.code){
      return;
    } else {
      return result.code;
    }
  }

  List<String> item = [];
  Future sendCode() async{

    Map<String, dynamic> args = {"assetCode": item, "id_period": idPeriod};
    var body = json.encode(args);

    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/stock_opname/scan/"+idPeriod.toString()),
        headers: {
          'Content-type': 'application/json'
        },
        body: body,
    );

    logger.d('${response.body}');

    return json.decode(response.body);

    // List<String> comments = ["RM-1638953151", "KLS-1638956223"];
    // Map<String, dynamic> args = {"assetCode": comments};
    // String url = "http://192.168.0.2:8000/api/stock_opname/scan";
    // var body = json.encode(args);
    // final response = await http
    //     .post(url, body: body, headers: {'Content-type': 'application/json'});
    //
    // logger.d('${response.body}');
    //
    // return json.decode(response.body);
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     controller.pauseCamera();
  //   }
  //   controller.resumeCamera();
  // }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Confirm delete?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: const Text('Delete'),
  //             onPressed: () {
  //               item.remove(context);
  //               setState(() {});
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  TextEditingController _qtyController = TextEditingController();

  Future saveQty() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/send_qty/"+item.toString()),
        body: {
          "asset_qty" : _qtyController.text
        }
    );

    logger.d('${response.body}');

    return json.decode(response.body);
  }

  Future updatePrecentage() async{
    final response =
    await http.put(Uri.parse("http://192.168.0.6:8000/api/update-precentage/"+idPeriod.toString()));

    logger.d('${response.body}');

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.check),
        onPressed: (){
          sendCode();
          updatePrecentage();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context)=>StockOpnameResult(idPeriod: idPeriod),
              ), (route) => false
          );
        },
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: RawMaterialButton(
                  //         elevation: 2.0,
                  //         fillColor: Color(0xFFF5CEB8),
                  //         padding: EdgeInsets.all(10.0),
                  //         shape: CircleBorder(),
                  //         onPressed: () async {
                  //           await controller?.toggleFlash();
                  //           setState(() {});
                  //         },
                  //         child: FutureBuilder(
                  //           future: controller?.getFlashStatus(),
                  //           builder: (context, snapshot) {
                  //             return Icon(Icons.flare_sharp);
                  //           },
                  //         ),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: RawMaterialButton(
                  //         elevation: 2.0,
                  //         fillColor: Color(0xFFF5CEB8),
                  //         padding: EdgeInsets.all(10.0),
                  //         shape: CircleBorder(),
                  //         onPressed: () async {
                  //           await controller?.pauseCamera();
                  //         },
                  //         child: Icon(Icons.pause),
                  //       ),
                  //     ),
                  //     Container(
                  //       margin: EdgeInsets.all(8),
                  //       child: RawMaterialButton(
                  //         elevation: 2.0,
                  //         fillColor: Color(0xFFF5CEB8),
                  //         padding: EdgeInsets.all(10.0),
                  //         shape: CircleBorder(),
                  //         onPressed: () async {
                  //           await controller?.resumeCamera();
                  //         },
                  //         child: Icon(Icons.play_arrow),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                    child: Text(
                      "Click asset code to add qty (Optional).",
                      textAlign: TextAlign.center,
                      style: TextStyle (color: Colors.red),
                    ),
                  ),
                  Expanded(child: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: item.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Container(
                          height: 50,
                          width: 400,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Input qty'),
                                    content: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: _qtyController,
                                      // onChanged: (text) {
                                      //   print("Last text field: $text");
                                      //   user.lastName = text;
                                      // },
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Submit'),
                                        onPressed: () async{
                                          final response =
                                          await http.post(Uri.parse("http://192.168.0.6:8000/api/send_qty/"+item[index].toString()),
                                              body: {
                                                "asset_qty" : _qtyController.text
                                              }
                                          );

                                          logger.d('${response.body}');
                                          _qtyController.clear();

                                          return Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
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
                                    Text(
                                      'Asset Code: '+item[index],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Icon(Icons.chevron_right),
                                  ],
                                ),
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
}