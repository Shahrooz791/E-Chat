import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_chat/controllers/contacts_controller.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:e_chat/view/core/widgets/custom_padding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../core/utils/assets.dart';
import '../../core/widgets/custom_text.dart';
import '../../core/widgets/input_field.dart';
import 'messaging.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final controller = Get.put(ContactsController());

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseFirestore.instance
        .collection('userData')
        .where('id', isNotEqualTo: uid);

    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),

      body: CustomPadding(
        child: Column(
          crossAxisAlignment: .start,

          children: [
            SizedBox(height: 47.h),

            CustomText(
              text: 'Contacts',
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
            ),

            Expanded(
              child: StreamBuilder(
                stream: ref.snapshots(),

                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('error');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Waiting');
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: const Text('No Contacts'));
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        Divider(color: MyColors.greyThree(context)),

                    itemCount: snapshot.data!.docs.length,

                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},

                        contentPadding: .zero,

                        title: CustomText(
                          text: snapshot.data!.docs[index]['name'],
                          fontWeight: .w600,
                          fontSize: 14,
                          color: MyColors.black(context),
                        ),

                        subtitle: CustomText(
                          text: snapshot.data!.docs[index]['bio'],
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
