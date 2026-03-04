import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/chat_bubble.dart';
import 'package:e_chat/view/core/widgets/custom_back_button.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import '../../../controllers/messaging_controller.dart';

class MessagingScreen extends StatefulWidget {

  final String? receiverUserEmail;
  final String? receiverUserID;

  const MessagingScreen({super.key,this.receiverUserEmail,this.receiverUserID});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {


  final controller = Get.put(MessagingController());
  final _auth = FirebaseAuth.instance;

  late String receiverUserID;
  late String receiverUserEmail;

  void sendMessage() async {
    if (controller.messageController.text.isNotEmpty) {
      await controller.sendMessage(

          receiverUserID,

          controller.messageController.text

      );

      //clear the controller after sending the message

      controller.messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map;

    receiverUserEmail = args['receiverUserEmail'];
    receiverUserID = args['receiverUserID'];


    return Scaffold(
      backgroundColor: MyColors.greyThree(context),

      appBar: AppBar(
        title: CustomText(
          text: receiverUserEmail,
          fontWeight: .w600,
          fontSize: 18,
          color: MyColors.black(context),
        ),

        centerTitle: true,

        backgroundColor: MyColors.white(context),

        leading: Align(alignment: .bottomRight, child: CustomBackButton()),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery
              .of(context)
              .viewInsets
              .bottom,
        ),

        child: Container(
          height: 90.h,

          width: .infinity,

          color: MyColors.bgWhite(context),

          child: Row(
            mainAxisAlignment: .spaceBetween,

            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: MyColors.grey(context)),
              ),

              SizedBox(
                width: 260,
                child: InputField(
                  controller: controller.messageController,
                  hintText: 'Enter Message',
                ),
              ),

              IconButton(
                onPressed: sendMessage,
                icon: SvgPicture.asset(
                  SvgImages.sendIcon,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ],
          ),
        ),
      ),

      body: _buildMessageList(),


    );


  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {


    Map<String,dynamic> data = document.data() as Map<String,dynamic>;

    //align the message to the right if the sender is the current user , other wise to the left

    var alignment = (data['senderId'] == _auth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(

        crossAxisAlignment: (data['senderId'] == _auth.currentUser!.uid) ? .end : .start ,
        mainAxisAlignment: (data['senderId'] == _auth.currentUser!.uid) ? .end : .start ,

        children: [

          Text(data['senderEmail']),
          ChatBubble(message: data['message']),

        ],

      ),
    );
  }

  //build message list
  Widget _buildMessageList(){
    return  StreamBuilder(

        stream: controller.getMessage(receiverUserID, _auth.currentUser!.uid),

        builder: (context, snapshot) {


          if(snapshot.hasError){
            return Text('Error') ;
          }

          if(snapshot.connectionState == ConnectionState.waiting){

            return Text('Loading...') ;

          }

          return ListView(

            children: snapshot.data!.docs.map((documents) => _buildMessageItem(documents),).toList(),

          ) ;


        },

    );
  }

}