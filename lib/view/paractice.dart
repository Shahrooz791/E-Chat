import 'package:flutter/material.dart';


class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(




    );
  }



}


/*
for localization
await context.setLocale(Locale('en'));

 */


/*
final controller = Get.put(ThemeChangerController());
for theme save

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

 */