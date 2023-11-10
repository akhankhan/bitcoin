// ignore_for_file: prefer_const_constructors

import 'package:bitcoinapp/customwidgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinScreen extends StatefulWidget {
  const CoinScreen({super.key});

  @override
  _CoinScreenState createState() => _CoinScreenState();
}

class _CoinScreenState extends State<CoinScreen> {
  String selectedCurrency = 'USD'; // Initially selected currency

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white, 
          ),
        ),
        title: Text(
          'Send Bitcoin',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Container(
          height: MediaQuery.of(context).size.height / 1.2,
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Send button tap
                    },
                    child: Text('Send'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Receive button tap
                    },
                    child: Text('Receive'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 30,
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 203, 214, 213)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    'BTC balance 0.00',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Handle Address button tap
                      },
                      child: Text('Address'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle Phone button tap
                      },
                      child: Text('Phone'),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle Email button tap
                      },
                      child: Text('Email'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Recipient Details',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: DropdownButton<String>(
                      underline: Container(),
                      borderRadius: BorderRadius.circular(12),
                      value: selectedCurrency,
                      onChanged: (newValue) {
                        setState(() {
                          selectedCurrency = newValue!;
                        });
                      },
                      items: <String>[
                        'USD',
                        'EUR',
                        'GBP',
                        'BTC',
                        // Add more currencies as needed
                      ].map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () {
                            // Handle the IconButton tap inside the TextField
                          },
                          icon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '~ \$ 0.00',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Center(
                child: Text(
                  'Total : 0.0 BTC /0.00 USD',
                  style: TextStyle(fontSize: 20, color: Colors.teal),
                ),
              ),
              SizedBox(height: 25.h),
              CustomButton(text: 'Send'),
              SizedBox(height: 15.h),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
