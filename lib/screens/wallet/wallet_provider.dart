import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../model/payment.dart';

class WalletScreenProvider with ChangeNotifier {
  PaymentModel paymentModel = PaymentModel();
  List<PaymentModel> paymentData = [];
  int totalAmount = 0;

  WalletScreenProvider() {
    getPayment();
  }

  getPayment() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userData = await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Payment")
        .get();

    if (userData.docs.isNotEmpty) {
      for (var element in userData.docs) {
        Map<String, dynamic> data = element.data();
        paymentData.add(PaymentModel.fromJson(data));
      }

      for (var element in paymentData) {
        //log("kk:${el}");
        int amount = int.parse(element.amount.toString());
        totalAmount += amount;
      }

      log("kk$totalAmount");

      notifyListeners();
    }
  }
}
