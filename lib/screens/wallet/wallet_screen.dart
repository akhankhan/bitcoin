import 'package:bitcoinapp/screens/wallet/wallet_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (context) => WalletScreenProvider(),
      child:
          Consumer<WalletScreenProvider>(builder: (context, valueModel, child) {
        return SafeArea(
          child: Column(
            children: [
              Container(
                height: 150,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Center(
                          child: Text(
                        "Total Amount",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )),
                    ),
                    Text(
                      "${valueModel.totalAmount.toString()} \$",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
