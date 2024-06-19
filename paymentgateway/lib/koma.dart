import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String urlResult = "";
  String hashCheckResult = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Request'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await makePaymentRequest();
              },
              child: Text('Make Payment Request'),
            ),
            SizedBox(height: 20),
            Text('URL Result: $urlResult'),
            Text('Hashcheck Result: $hashCheckResult'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                launchGoogleUrl();
              },
              child: Text('Launch Google URL'),
            ),
          ],
        ),
      ),
    );
  }


  void launchGoogleUrl() {
    String googleUrl = urlResult;
    // Use window.location to navigate to the URL
    if (googleUrl != null && googleUrl.isNotEmpty) {
      // Use window.location to open the URL in the same tab
      window.location.href = googleUrl;
    }
  }



  Future<void> makePaymentRequest() async {
    String bankReference = 'benwhiji4';
    String hash = generateRequestHas(bankReference);

    // String apiUrl = "https://api.ozow.com/postpaymentrequest";
    //  String apiUrl = "https://us-central1-survay1-38c88.cloudfunctions.net/makePaymentRequest";

    Map<String, String> headers = {
      "Accept": "application/json",
      "ApiKey": "aUcwYW4cpx2xAOaMu8DEnJmQ9JUvJHVD",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "GET, POST",
      "Access-Control-Allow-Headers": "X-Requested-With",
    };

    Map<String, dynamic> data = {
      "countryCode": "ZA",
      "amount": "0.01",
      "transactionReference": "benwhiji4",
      "bankReference": "benwhiji4",
      "cancelUrl": "http://google.com",
      "currencyCode": "ZAR",
      "errorUrl": "http://test.i-pay.co.za/responsetest.php",
      "isTest": false,
      "notifyUrl": "http://test.i-pay.co.za/responsetest.php",
      "siteCode": "SOF-SOF-008",
      "successUrl": "http://test.i-pay.co.za/responsetest.php",
      "hashCheck": hash,
    };

    // http.Response response = await http.post(
    //   Uri.parse(apiUrl),
    //   headers: headers,
    //   body: jsonEncode(data),
    // );

    http.Response response = await http.post(
      Uri.parse("https://us-central1-survay1-38c88.cloudfunctions.net/yourCloudFunctionName/postpaymentrequest"), // Use your server URL
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Update the state variables
      setState(() {
        urlResult = jsonResponse['url'];
        hashCheckResult = calculatedHashResult;
      });

      // Print the URL and the hash check
      print("URL: $urlResult");
      print("Hashcheck: $hashCheckResult");
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  }

  String calculatedHashResult = "";

  String generateRequestHashCheck(String inputString) {
    var sha = sha512.convert(utf8.encode(inputString));
    return sha.toString();
  }

  String generateRequestHas(String bankReference) {

    String siteCode = 'SOF-SOF-008';
    String countryCode = 'ZA';
    String currencyCode = 'ZAR';
    double amount = 0.01;
    String transactionReference = 'benwhiji4';
    String cancelUrl = 'https://softmeet.co.za/contact.php';
    String errorUrl = 'http://test.i-pay.co.za/responsetest.php';
    String successUrl = 'http://test.i-pay.co.za/responsetest.php';
    String notifyUrl = 'http://test.i-pay.co.za/responsetest.php';
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
}
