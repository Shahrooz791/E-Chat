import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MessagingController extends GetxController {
  TextEditingController messageController = TextEditingController();


  @override
  void onClose() {
    // TODO: implement onClose
    messageController.dispose();
    super.onClose();
  }

  final _auth = FirebaseAuth.instance;

  final _ref = FirebaseFirestore.instance;

  //Send Message

  Future<void> sendMessage(String receiverID, String message) async {
    //get current info
    final currentId = _auth.currentUser!.uid;
    final currentEmail = _auth.currentUser!.email.toString();
    final timeStamp = Timestamp.now();

    //create a new message

    final newMessage = MessageModel(
      senderId: currentId,
      senderEmail: currentEmail,
      receiverId: receiverID,
      message: message,
      timestamp: timeStamp,
    );

    //construct chat room id from current user id and receiver id (sorted to ensure uniqueness)

    List<String> ids = [currentId, receiverID];

    ids.sort();

    String chatRoomID = ids.join(
      "_",
    ); //combine the ids into a single String to use a chatRoomID

    //add new message to database

    _ref
        .collection('chat_room')
        .doc(chatRoomID)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //Get Message

  Stream<QuerySnapshot> getMessage(String userId, String otherUserID) {
    List<String> ids = [userId, otherUserID];

    ids.sort();

    String chatRoomID = ids.join("_");

    return _ref
        .collection('chat_room')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
