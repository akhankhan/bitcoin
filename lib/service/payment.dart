import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  Map<String, dynamic>? paymentIntent;

  Future<Map<String, dynamic>> makePayment(String amount) async {
    try {
      print("clickk....");
      paymentIntent = await createPaymentIntend(amount);
      String paymentIntentId =
          paymentIntent!['id']; // Here's your Payment Intent ID
      log("payment iddddddddd:::$paymentIntentId");

      var googlePayment = const PaymentSheetGooglePay(
        merchantCountryCode: "US",
        currencyCode: "USD",
        testEnv: true,
      );
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent!['client_secret'],
        style: ThemeMode.light,
        merchantDisplayName: "bitcoinapp",
        googlePay: googlePayment,
      ));
      final success = await displayPayment();
      Map<String, dynamic> isPaymentSuccess = {
        "sccuess": success,
        "payment_Intend_id": paymentIntentId,
      };
      return isPaymentSuccess;
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<bool> displayPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<dynamic> createPaymentIntend(String amount) async {
    int price = int.parse(amount) * 100;
    log("amount::::$amount");
    try {
      Map<String, dynamic> body = {
        "amount": price.toString(),
        "currency": "USD",
      };

      http.Response response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51O4mg3AwPsZVIyyPXP3cUyvOfiMuB9zVovtNzxtnN2PclKGFcbVoN9VgsGUE7rFxu3Ms7KMGQ4JCtqgw7vEbhkMw00PPxRbZyB',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("PaymentIntent ID: ${data['id']}");
      } else {
        print('Failed to create PaymentIntent');
      }
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
