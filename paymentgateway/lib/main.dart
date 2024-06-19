import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Status Checker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentStatusScreen(),
    );
  }
}

class PaymentStatusScreen extends StatefulWidget {
  @override
  _PaymentStatusScreenState createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  final TextEditingController _transactionController = TextEditingController();
  String _paymentStatus = '';

  Future<void> _checkPaymentStatus( String n) async {
    final Uri cloudFunctionUrl = Uri.parse(
        'https://us-central1-survay1-38c88.cloudfunctions.net/checkPaymentStatus?transactionReference=${_transactionController
            .text}');
    final response = await http.get(cloudFunctionUrl);

    if (response.statusCode == 200) {
      setState(() {
        _paymentStatus = "payment Succeful";
        //TODO: Add reference to cvSubscriberList table
      });
    } else if (response.statusCode == 404) {
      setState(() {
        _paymentStatus = "Payment not made yet";
      });
    } else {
      setState(() {
        _paymentStatus = "no payment was made";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}