import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'mainn.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cash in via EFT',
      theme: ThemeData(
        primaryColor: Colors.white, // Set background color to white
        scaffoldBackgroundColor: Colors.white, // Set scaffold background color to white
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, // Set app bar icon color to black
          ), toolbarTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.black, // Set app bar text color to black
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ).bodyText2, titleTextStyle: TextTheme(
            headline6: TextStyle(
              color: Colors.black, // Set app bar text color to black
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ).headline6,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late WebViewController _webViewController;
  String calculatedHashResult = "";

  String generateRequestHashCheck(String inputString) {
    var sha = sha512.convert(utf8.encode(inputString));
    return sha.toString();
  }

  String generateRequestHash() {
    String siteCode = 'SOF-SOF-008';
    String countryCode = 'ZA';
    String currencyCode = 'ZAR';
    double amount = 0.01;
    String transactionReference = 'Percy';
    String bankReference = 'Percy';
    String cancelUrl = 'https://payment-urls.vercel.app/cancel.html';
    String errorUrl = 'https://payment-urls.vercel.app/error.html';
    String successUrl = 'https://payment-urls.vercel.app/success.html';
    String notifyUrl = 'https://payment-urls.vercel.app/notify.html';
    String privateKey = 'lX06ZseA7zKKSX3QxOvEC4GkF86OIRwR';
    bool isTest = false;

    String inputString = (
        siteCode +
            countryCode +
            currencyCode +
            amount.toString() +
            transactionReference +
            bankReference +
            cancelUrl +
            errorUrl +
            successUrl +
            notifyUrl +
            isTest.toString() +
            privateKey
    );
    inputString = inputString.toLowerCase();
    calculatedHashResult = generateRequestHashCheck(inputString);
    print("Hashcheck: $calculatedHashResult");

    return calculatedHashResult;
  }

  Future<String> fetchPaymentUrl() async {
    String hashCheck = generateRequestHash();

    String url = "https://us-central1-survay1-38c88.cloudfunctions.net/yourCloudFunctionName/postpaymentrequest";

    Map<String, String> headers = {
      "Accept": "application/json",
      "ApiKey": "aUcwYW4cpx2xAOaMu8DEnJmQ9JUvJHVD",
      "Content-Type": "application/json",
    };

    Map<String, dynamic> data = {
      "countryCode": "ZA",
      "amount": "0.01",
      "transactionReference": 'Percy',
      "bankReference": 'Percy',
      "cancelUrl": 'https://payment-urls.vercel.app/cancel.html',
      "currencyCode": "ZAR",
      "errorUrl": 'https://payment-urls.vercel.app/error.html',
      "isTest": false,
      "notifyUrl": 'https://payment-urls.vercel.app/notify.html',
      "siteCode": "SOF-SOF-008",
      "successUrl": 'https://payment-urls.vercel.app/success.html',
      "hashCheck": hashCheck,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String paymentUrl = jsonResponse['url'];
      print("Payment URL: $paymentUrl");
      return paymentUrl;
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_outlined), // Set leading icon to cancel icon
          onPressed: () {
            // Handle cancel button press if needed
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyAppa()),
            );
          },
        ),
        title: Text('Cash in via EFT',),
      ),
      body: FutureBuilder<String>(
        future: fetchPaymentUrl(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              String paymentUrl = snapshot.data ?? '';
              if (paymentUrl.isNotEmpty) {
                return WebView(
                  initialUrl: paymentUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController controller) {
                    _webViewController = controller;
                  },
                );
              } else {
                return Center(child: Text('Failed to fetch payment URL'));
              }
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
