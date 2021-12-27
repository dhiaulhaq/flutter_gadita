import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gadita/screens/assets_screen.dart';
import 'package:gadita/screens/lending_screen.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddLendingScreen extends StatefulWidget{

  final int idProduct;
  final String nameProduct, codeProduct;
  AddLendingScreen({
    Key key,
    @required this.idProduct,
    @required this.nameProduct,
    @required this.codeProduct
  }) : super(key: key);

  // final Text text;
  // final String idProduct;
  // AddLendingScreen({this.idProduct});

  @override
  _AddLendingScreenState createState() => _AddLendingScreenState(idProduct, nameProduct, codeProduct);
}

class _AddLendingScreenState extends State<AddLendingScreen> {
  int idProduct;
  String nameProduct, codeProduct;
  _AddLendingScreenState(
      this.idProduct,
      this.nameProduct,
      this.codeProduct
      );

  DateTime selectedDate = DateTime.now();

  String title;
  DateTime date;
  String strDate;
  String startTime;
  String endTime;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _borrowerController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeStartController = TextEditingController();
  TextEditingController _timeEndController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future saveProduct() async{
    final response =
    await http.post(Uri.parse("http://192.168.0.6:8000/api/lending/"+idProduct.toString()),
        body: {
          "borrower" : _borrowerController.text,
          "qty" : _qtyController.text,
          "description" : _descriptionController.text,
          "date" : _dateController.text,
          "time_start" : _timeStartController.text,
          "time_end" : _timeEndController.text,
          "phone" : _phoneController.text,
        }
    );

    return json.decode(response.body);
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date ?? now,
        firstDate: now,
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      print('hello $picked');
      setState(() {
        date = picked;
      });
    }
  }

  Widget buildNameField() {
    return TextFormField(
      controller: _borrowerController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Name of Borrower',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name of Borrower is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildQtyField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _qtyController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Qty',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Qty is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildDateField() {
    return TextFormField(
      controller: _dateController,
      onTap: () async {
        // Below line stops keyboard from appearing
        FocusScope.of(context).requestFocus(new FocusNode());
        // Show Date Picker Here
        await _selectDate(context);
        _dateController.text = DateFormat('dd/MM/yyyy').format(date);
        //setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Borrow Date',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        print('date:: ${date.toString()}');
        if (value.isEmpty) {
          return 'Borrow Date is Required.';
        }
        return null;
      },
      onSaved: (String val) {
        strDate = val;
      },
    );
  }

  Widget buildStartTimeField({labelText, labelType}) {
    return TextFormField(
      controller: _timeStartController,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        TimeOfDay pickedTime =  await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if(pickedTime != null ){
          print(pickedTime.format(context));   //output 10:51 PM
          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
          //converting to DateTime so that we can further format on different pattern.
          print(parsedTime); //output 1970-01-01 22:53:00.000
          String formattedTime = DateFormat('HH:mm').format(parsedTime);
          print(formattedTime); //output 14:59:00
          //DateFormat() is from intl package, you can format the time on any pattern you need.

          setState(() {
            _timeStartController.text = formattedTime; //set the value of text field.
          });
        }else{
          print("Time is not selected");
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Start Time is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        if (labelType == 'startTime') {
          startTime = value;
        } else {
          endTime = value;
        }
      },
    );
  }

  Widget buildEndTimeField({labelText, labelType}) {
    return TextFormField(
      controller: _timeEndController,
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        TimeOfDay pickedTime =  await showTimePicker(
          initialTime: TimeOfDay.now(),
          context: context,
        );

        if(pickedTime != null ){
          print(pickedTime.format(context));   //output 10:51 PM
          DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
          //converting to DateTime so that we can further format on different pattern.
          print(parsedTime); //output 1970-01-01 22:53:00.000
          String formattedTime = DateFormat('HH:mm').format(parsedTime);
          print(formattedTime); //output 14:59:00
          //DateFormat() is from intl package, you can format the time on any pattern you need.

          setState(() {
            _timeEndController.text = formattedTime; //set the value of text field.
          });
        }else{
          print("Time is not selected");
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'End Time is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        if (labelType == 'endTime') {
          startTime = value;
        } else {
          endTime = value;
        }
      },
    );
  }

  Widget buildReasonField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Reason',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Reason is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  Widget buildPhoneField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Phone Number',
        contentPadding: EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 12.0,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required.';
        }
        return null;
      },
      onSaved: (String value) {
        title = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5CEB8),
        title: Text('Add Lending', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(
            builder: (context)=>AssetsScreen(),
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Lending Form',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  nameProduct+' ('+codeProduct+')',
                ),
                SizedBox(
                  height: 20.0,
                ),
                buildNameField(),
                SizedBox(
                  height: 20.0,
                ),
                buildQtyField(),
                SizedBox(
                  height: 20.0,
                ),
                buildReasonField(),
                SizedBox(
                  height: 20.0,
                ),
                buildDateField(),
                SizedBox(
                  height: 20.0,
                ),
                buildStartTimeField(labelText: 'Start Time', labelType: 'startTime'),
                SizedBox(
                  height: 20.0,
                ),
                buildEndTimeField(labelText: 'End Time', labelType: 'endTime'),
                SizedBox(
                  height: 20.0,
                ),
                buildPhoneField(),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  color: Colors.black54,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    saveProduct().then((value) {
                      Navigator.push(
                          context, MaterialPageRoute(
                        builder: (context)=>LendingScreen(),
                      ));
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}