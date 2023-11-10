// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'chat_screen_provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider(
      create: (_) => ChatScreenProvider(),
      child:
          Consumer<ChatScreenProvider>(builder: (context, valueModel, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, left: 10, right: 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/skyvalletlogo.png',
                          height: 40.h,
                          width: 40.w,
                        ),
                        SizedBox(width: 20.w),
                        Text(
                          'Hi there 👋',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Spacer(),
                        Icon(
                          Icons.view_headline_rounded,
                          size: 25,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10.w),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 25,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 0.h),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                shrinkWrap: true,
                // Add your chat messages here
                itemCount: valueModel.chatList.length, // Example message count
                itemBuilder: (context, index) {
                  // Replace with your chat message widgets
                  return Row(
                    mainAxisAlignment: valueModel.uid.toString() ==
                            valueModel.chatList[index].id.toString()
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // Background color
                            borderRadius:
                                BorderRadius.circular(12.0), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3), // Shadow offset
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${valueModel.chatList[index].message}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                valueModel.dateTimeFormate(
                                  valueModel.chatList[index].date.toString(),
                                ),
                                style: TextStyle(
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            // Chat input field and send button
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.grey), // Divider line
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: valueModel.message,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      valueModel.sendMessage();
                      valueModel.message.text = '';
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    ));
  }
}
