import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/chat.dart';
import '../../service/chat_service.dart';

class ChatScreenProvider with ChangeNotifier {
  ChatModel chatModel = ChatModel();
  ChatDao chatDao = ChatDao();
  final chatList = <ChatModel>[];
  String uid = '';

  ChatScreenProvider() {
    getUserId();
    getMessage();
  }

  TextEditingController message = TextEditingController();

  void getUserId() {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    uid = userId;
    notifyListeners();
  }

  void sendMessage() {
    log("ssend");
    String userId = FirebaseAuth.instance.currentUser!.uid;

    chatModel.message = message.text;
    chatModel.date = DateTime.now();

    chatModel.id = userId;
    chatDao.saveMessage(chatModel, userId);
    notifyListeners();
  }

  getMessage() {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    Stream stream = chatDao.listenToMessages(userId);
    stream.listen((event) {
      print("check1123: ${event.snapshot.value.toString()}");
      ChatModel message =
          ChatModel.fromJson(Map<String, dynamic>.from(event.snapshot.value));

      chatList.insert(0, message);

      message = ChatModel();
      notifyListeners();
    });
  }

  String dateTimeFormate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    DateFormat format = DateFormat('h:mm a');

    String formattedTime = format.format(dateTime);
    return formattedTime;
  }
}
