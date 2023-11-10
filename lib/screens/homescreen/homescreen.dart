// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:developer';

import 'package:bitcoinapp/customwidgets/coinsbottomsheet.dart';
import 'package:bitcoinapp/screens/chat_screen/chat_screen.dart';
import 'package:bitcoinapp/screens/coins_screens/coin_screen.dart';
import 'package:bitcoinapp/screens/homescreen/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../deposit/deposit_screen.dart';
import '../wallet/wallet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: ChangeNotifierProvider(
        create: (context) => HomeScreenProvider(),
        child: Consumer<HomeScreenProvider>(builder: (context, value, child) {
          return Container(
            //color: Colors.white,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.topCenter,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   bottomLeft: Radius.elliptical(30, 8),
                        //   bottomRight: Radius.elliptical(30, 8),
                        // ),
                        color: Colors.teal,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 50, right: 20, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(),
                                GestureDetector(
                                  onTap: () {
                                    value.getCriptoData();
                                  },
                                  child: Text(
                                    'Welcome Christ',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                                Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20, // Adjust as needed for spacing
                          ),
                          Container(
                            width: 200.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(
                                  25), // Rounded container
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 0),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Text("Select value"),
                                iconSize: 30.0,
                                dropdownColor: Colors.grey[200],
                                underline: Container(
                                  height:
                                      0, // Set the height to 0 to remove the bottom line
                                  color: Colors
                                      .transparent, // Make the line transparent
                                ),
                                value: value.selectedValue,
                                items: value.items.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  String item = entry.value;
                                  String bitCoinData =
                                      value.bitCoinData[index].toString();
                                  Widget image = value.image[index];
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: image,
                                        ),
                                        Text(item),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            value.fixString(bitCoinData) ?? "",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ), // Display data from bitCoinData alongside the item
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  log("checkkkkkkkkkkkk:::$newValue");
                                  value.dropDownButton(newValue);
                                  // setState(() {
                                  //   selectedValue = newValue!;
                                  // });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            value.btcUsdtPrice,
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12.h),

                          // Text(
                          //   value.currencyList[1].value.toString(),
                          //   style: TextStyle(
                          //       fontSize: 16,
                          //       color: Colors.tealAccent,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                        //color: Colors.white,
                        width: 400.w,
                        padding: EdgeInsets.only(top: 223, left: 55, right: 55),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25, left: 30, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChatScreen()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 161, 190, 204),
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Icon(Icons.send)),
                                      Text('Send'),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CoinScreen()));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: 30.h,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 161, 190, 204),
                                              borderRadius:
                                                  BorderRadius.circular(35)),
                                          child: Icon(
                                              Icons.qr_code_scanner_outlined)),
                                      Text('Recieve'),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 161, 190, 204),
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Icon(Icons.swap_calls)),
                                    Text('Swap'),
                                  ],
                                )
                              ],
                            ),
                          ),
                          height: 100,
                          width: 200,
                        )),
                  ],
                ),
                SizedBox(height: 20.h), // Adjust the spacing as needed
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GridView.count(
                    crossAxisCount: 3, // Number of columns in the grid
                    shrinkWrap:
                        true, // To make GridView scrollable within a Column
                    physics:
                        NeverScrollableScrollPhysics(), // Disable GridView scrolling
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => WalletScreen())));
                        },
                        child: GridItem(
                          image: Icons.wallet,
                          text: 'Wallet',
                        ),
                      ),
                      GridItem(image: Icons.card_membership_sharp, text: 'Buy'),
                      GridItem(
                        image: Icons.sell,
                        text: 'Sell',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DepositScreen(),
                            ),
                          );
                        },
                        child: GridItem(
                          image: Icons.branding_watermark_outlined,
                          text: 'Deposit',
                        ),
                      ),
                      GridItem(
                        image: Icons.width_wide_sharp,
                        text: 'Withdraw',
                      ),
                      GridItem(
                        image: Icons.save,
                        text: 'Save',
                      ),
                      // Add more GridItem widgets as needed
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  height: 70.h,
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Colors.amber[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invite your Friends and earn',
                                style: TextStyle(
                                  fontSize:
                                      18, // Adjust the font size as needed
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'You earn 0.5\$ on your friend transactions',
                                style: TextStyle(
                                  fontSize:
                                      14, // Adjust the font size as needed
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Add functionality for the "Invite" button
                          },
                          child: Text('Invite'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.teal, // Change button color as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    ));
  }
}

class GridItem extends StatelessWidget {
  final IconData image;
  final String text;

  const GridItem({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90.h,
          width: 90.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white, // Example color
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(image),
              SizedBox(height: 5.h),
              Text(text),
            ],
          ), // Replace with your image
        ),
      ],
    );
  }
}
