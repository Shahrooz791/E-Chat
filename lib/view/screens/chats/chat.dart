import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:e_chat/view/core/widgets/custom_text.dart';
import 'package:e_chat/view/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../controllers/contacts_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = Get.put(ContactsController());

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // final uid = FirebaseAuth.instance.currentUser!.uid;

    //final ref = FirebaseFirestore.instance
    //  .collection('userData')
    //.where('id', isNotEqualTo: uid);

    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),

      body: CustomPadding(
        child: Column(
          crossAxisAlignment: .start,

          children: [
            SizedBox(height: 47.h),

            CustomText(
              text: 'Chats',
              fontWeight: .w600,
              fontSize: 18,
              color: MyColors.black(context),
            ),

            SizedBox(height: 20.h),

            InputField(
              controller: controller.searchController,
              hintText: 'Search',
              prefixIcon: Column(
                mainAxisAlignment: .center,

                children: [
                  SvgPicture.asset(
                    SvgImages.searchIcon,
                    height: 24.h,
                    width: 24.w,
                  ),
                ],
              ),

              onChanged: (value) {
                controller.searchText.value = value;
              },
            ),

            Expanded(child: _builderUserList()),
          ],
        ),
      ),
    );
  }

  Widget _builderUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('userData').snapshots(),

      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: CustomText(
              text: 'Error${snapshot.hasError.toString()}',
              fontWeight: .w600,
              fontSize: 18,
              color: MyColors.black(context),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CustomText(
              text: 'Loading...',
              fontWeight: .w600,
              fontSize: 18,
              color: MyColors.black(context),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CustomText(
              text: 'No Data',
              fontWeight: .w600,
              fontSize: 18,
              color: MyColors.black(context),
            ),
          );
        }

        return Obx(() {
          var docs = snapshot.data!.docs.where((doc) {
            String name = doc['name'];

            return name.toLowerCase().contains(
              controller.searchText.value.toLowerCase(),
            );
          }).toList();

          return ListView.builder(
            itemCount: docs.length,

            itemBuilder: (context, index) {
              String name = docs[index]['name'];

              return ListTile(
                contentPadding: .zero,

                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/MessagingScreen',
                    arguments: {
                      'receiverUserEmail': docs[index]['email'],
                      'receiverUserID': docs[index]['id'],
                      'receiverUserName': docs[index]['name'],
                    },
                  );
                },

                title: CustomText(
                  text: name,
                  fontWeight: .w600,
                  fontSize: 14,
                  color: MyColors.black(context),
                ),

                subtitle: CustomText(
                  text: docs[index]['bio'],
                  fontWeight: .w400,
                  fontSize: 12,
                  color: MyColors.grey(context),
                ),

                leading: Container(
                  height: 48.h,

                  width: 48.w,

                  decoration: BoxDecoration(
                    borderRadius: .circular(16.r),

                    image: DecorationImage(
                      fit: .contain,
                      image: NetworkImage(
                        'https://static.vecteezy.com/system/resources/previews/052/755/981/non_2x/a-man-profile-avatar-icon-with-a-white-background-free-vector.jpg',
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
