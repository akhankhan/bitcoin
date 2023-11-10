import 'package:firebase_database/firebase_database.dart';

import '../model/chat.dart';

class ChatDao {
  final DatabaseReference _messagesRef =
      FirebaseDatabase.instance.ref().child('chats');

  void saveMessage(
    ChatModel message,
    String senderId,
  ) {
    _messagesRef.child(senderId).push().set(message.toJson());
  }

  // Query getMessageQuery() {
  //   return _messagesRef;
  // }

  Stream listenToMessages(String senderId) {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child('chats');
    Stream stream;
    stream = databaseReference.child(senderId).onChildAdded;
    return stream;
  }
}
