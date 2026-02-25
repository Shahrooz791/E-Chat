
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ThemeChangerDb {

  ThemeChangerDb._();


  static final ThemeChangerDb getInstance = ThemeChangerDb._();


  Database? myDB;


  static final String tableName = 'theme';
  static final String id = 'id';
  static final String save = 'change';


  Future<Database> getDb()async{

    if(myDB != null){

      return myDB!;

    }else{

      myDB = await openDb();

      return  myDB!;

    }


  }


  Future<Database> openDb()async{

    Directory appDir = await getApplicationDocumentsDirectory();

    String dbPath = join(appDir.path,"Theme.db");

    return await  openDatabase(dbPath,version: 1,


      onCreate: (db, version) {

      db.execute(

        '''
        CREATE TABLE $tableName (
        $id INTEGER PRIMARY KEY AUTOINCREMENT,
        $save INTEGER
        )
        '''


      );

      },


    );


  }



  //queries
   Future<void> setTheme(bool value)async{

    var db = await getDb();

    var data = await db.query(tableName);

    if(data.isEmpty){


      await db.insert(tableName, {

        save : 0

      });

      debugPrint('Insert');


    }else{



      await db.update(tableName, {

        save : value ? 1 : 0


      });

      debugPrint('Updated');

    }

   }


   Future<List<Map<String , dynamic>>> getTheme()async{

    var db = await getDb();

     List<Map<String , dynamic>> data = await  db.query(tableName);

     return data;

   }



}