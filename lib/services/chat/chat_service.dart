import 'package:chat_appication_vs/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and fire store
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // send the message
  Future<void> sendMessage(String reciverId, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    //create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        message: message,
        reciverId: reciverId,
        timestamp: timestamp);
    //construct chat room id for current user id and receiver id

    List<String> ids = [currentUserId, reciverId];
    ids.sort(); // sort this ensures that the chat room id is always the same for any pair of people
    String chatRoomId = ids.join("_"); //joining them by _
    // add new message to database
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // get the message>
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    // construct chat room id from user ids (sort them so that it matches the room id when user send message
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRommId = ids.join("_");
    return _firestore
        .collection('chat_rooms')
        .doc(chatRommId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
