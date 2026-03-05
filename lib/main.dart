import 'package:e_chat/controllers/theme_changer_controller.dart';
import 'package:e_chat/view/core/utils/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('ar'),
        Locale('da'),
        Locale('en'),
        Locale('hi'),
        Locale('hr'),
        Locale('id'),
        Locale('ph'),
        Locale('ur'),
        Locale('zh'),
      ],

      path: 'assets/translations',

      fallbackLocale: Locale('en'),

      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThemeChangerController());

    return Obx(
      () => MaterialApp(
        //GetMaterialApp
        title: 'E-Chat',

        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          brightness: .light,
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),

        darkTheme: ThemeData(brightness: .dark),

        themeMode: controller.themeMode.value,

        supportedLocales: context.supportedLocales,
        locale: context.locale,
        //fallbackLocale: context.fallbackLocale,
        localizationsDelegates: context.localizationDelegates,

        routes: MyRoutes.routes,

        initialRoute: '/',
      ),
    );
  }
}
