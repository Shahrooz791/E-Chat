import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controllers/theme_changer_controller.dart';
import '../db/theme_changer_db.dart';
import 'core/utils/colors.dart';


class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {


  final controller = Get.put(ThemeChangerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(




    body: Column(



      children: [



        Container(
          height: 200,
          width: 200,
          color: MyColors.primaryBlue(context),
        ),


        Obx(() => Switch(value: controller.value.value, onChanged: (newValue){
          controller.getNewValue(newValue);

        }),),











        Expanded(
          child: FutureBuilder(


            future: ThemeChangerDb.getInstance.getTheme(),


            builder: (context, snapshot) {


              return  ListView.builder(

                itemCount: snapshot.data!.length,

                itemBuilder: (context, index) {


                  return ListTile(

                    title: Text(snapshot.data![index]['id'].toString()),
                    subtitle: Text(snapshot.data![index]['change'].toString()),



                  )  ;



                },)  ;


            },),
        )





      ],


    ),



    );
  }



}


/*
for localization
await context.setLocale(Locale('en'));

 */


