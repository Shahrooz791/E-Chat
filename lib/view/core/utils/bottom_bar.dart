import 'package:e_chat/controllers/bottom_bar_controller.dart';
import 'package:e_chat/view/core/utils/assets.dart';
import 'package:e_chat/view/core/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.bgWhite(context),

      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: MyColors.bgWhite(context),

          fixedColor: MyColors.primaryBlue(context),

          onTap: (index) {
            controller.selectIndex.value = index;
          },

          //type: .fixed,

          //showSelectedLabels: true,
          currentIndex: controller.selectIndex.value,

          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                SvgImages.chat,
                color: MyColors.black(context),
              ),
              label: StringTranslateExtension("Chats").tr(),
              activeIcon: SvgPicture.asset(
                SvgImages.chat,
                color: MyColors.primaryBlue(context),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz, color: MyColors.black(context)),
              label: StringTranslateExtension('More').tr(),
              activeIcon: Icon(
                Icons.more_horiz,
                color: MyColors.primaryBlue(context),
              ),
            ),
          ],
        ),
      ),

      body: Obx(() => controller.screens[controller.selectIndex.value]),
    );
  }
}
