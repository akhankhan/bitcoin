// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BitcoinSelectionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Crypto',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                'assets/images/bitcoin.jpeg',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Bitcoin'),
              SizedBox(width: 5.w),
              Text(
                'Bal (0.1)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          // Add other cryptocurrencies here
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/binance.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Binance'),
              SizedBox(width: 5.w),
              Text(
                'Bal (2.1)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/busd.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Busd'),
              SizedBox(width: 5.w),
              Text(
                'Bal (5.1)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/etherium.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Etherium'),
              SizedBox(width: 5.w),
              Text(
                'Bal (0.3)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/litecoin.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('LiteCoin'),
              SizedBox(width: 5.w),
              Text(
                'Bal (4.2)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/tron.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('LiteCoin'),
              SizedBox(width: 5.w),
              Text(
                'Bal (3.1)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          Row(
            children: [
              Image.asset(
                'assets/images/tehter.png',
                width: 30,
                height: 30,
              ),
              SizedBox(width: 10),
              Text('Thther'),
              SizedBox(width: 5.w),
              Text(
                'Bal (1.1)',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
