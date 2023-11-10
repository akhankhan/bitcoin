import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../service/payment.dart';

class DepositScreenProvider with ChangeNotifier {
  DepositScreenProvider() {
    getUserData();
  }

  final _paymentService = PaymentService();

  String name = '';
  TextEditingController nameController = TextEditingController();
  TextEditingController ammountContorller = TextEditingController();

  getUserData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    final userData =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (userData.exists) {
      nameController.text = userData["name"];
    }
    notifyListeners();
  }

  Future<void> intentPayment() async {
    Map<String, dynamic> isPaymentSuccess =
        await _paymentService.makePayment(ammountContorller.text.toString());

    if (isPaymentSuccess["sccuess"]) {
      await storePaymentData();
      const SnackBar(content: Text("Your payment has been successfully"));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => ))
    }
  }

  storePaymentData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid.toString();
    DocumentReference paymentRef = FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Payment")
        .doc();

    String paymentId = paymentRef.id;

    await paymentRef.set({
      "amount": ammountContorller.text.toString(),
      "date_time": DateTime.now().toString(),
      "id": paymentId,
    });
  }
}
