import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/module.dart';
import '../../services/module.dart';

class DatabaseService{

  static final DatabaseService _instance=DatabaseService.internal();
  factory DatabaseService()=>_instance;
  static  Database? _db;





  DatabaseService.internal();

  initDB() async{
    final database=openDatabase(join(await getDatabasesPath(),"geoapp.db"),
        version: 2,onCreate: _onCreate,onUpgrade: _onUpgrade
    );

    return database;
  }

  void _onCreate(Database db,int version) async{
    Batch batch=db.batch();
    /*batch.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "name varchar(20),surname varchar(20),email varchar(20),"
        "phone_number varchar(20),password TEXT)");*/
    batch.execute("CREATE TABLE IF NOT EXISTS users(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "user_id INTEGER,name TEXT,email TEXT,user_type TEXT,mobile TEXT)");
    batch.execute("CREATE TABLE IF NOT EXISTS preferences(id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "user_id INTEGER,user_state TEXT,"
        "isLoggedIn bit,token TEXT"
        ")");


    List<dynamic> res=await batch.commit();



  }
  void _onUpgrade(Database db,int oldVersion,int newVersion) async{
    db.execute('DROP TABLE IF EXISTS users');
    db.execute('DROP TABLE IF EXISTS preferences');
    db.execute('DROP TABLE IF EXISTS languages');
    db.execute('DROP TABLE IF EXISTS addresses');
    db.execute('DROP TABLE IF EXISTS dictionaries');
    db.execute('DROP TABLE IF EXISTS payment_methods');
  }

  Future<Database?> get db async{


    if(_db!=null){
      return _db;
    }

    else{
      _db=await initDB();

    }

    return _db;

  }


  Future<int> insertPreference(Preferences preferences) async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.insert("preferences",preferences.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    else{
      return -100;
    }
  }

  Future<int> insertUser(User user) async{
    final Database? dbClient=await db;
    if(dbClient!=null){
      return await dbClient.insert("users",user.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    }

    else{
      return -100;
    }
  }


  Future<int> deleteAccount() async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.delete("preferences");
    }

    else{
      return -100;
    }
  }

  Future<int> deleteUser() async{
    final Database? dbClient=await db;

    if(dbClient!=null){
      return await dbClient.delete("users");
    }

    else{
      return -100;
    }
  }

  Future<User?> getUser() async{
    final Database? dbClient=await db;
    if(dbClient!=null){
      List<Map<String,dynamic>> result=
      await dbClient.query(
        "users",columns: ["user_id","name","email","user_type",
        "mobile",],

      );

      if(result.isNotEmpty){
        print("users are " + result.first.toString());
        User user=User.fromDB(result.first);
        return user;
      }
      else{
        return null;
      }
    }

    else{
      return null;
    }
  }
  
  Future<Preferences?> getPreferences(int isLoggedIn) async{
    try{
      final Database? dbClient=await db;
      if(dbClient!=null){
        final Map<String,dynamic>? account_map=await dbClient.query(
          'preferences',columns: [
            "id","user_id","isLoggedIn","user_state"
        ],
          where: "isLoggedIn=?",
          whereArgs: [isLoggedIn]
        ).then((value){
          if(value.isNotEmpty){
            return value.first;
          }

          else{
            return null;}});

        if(account_map!=null){

          final Map<String,dynamic>? user_map=await dbClient.query(
            'users',columns: [
             "id","user_id","name","email","user_type","mobile"
          ],
            where: "user_id=?",
            whereArgs: [account_map["user_id"]]
          ).then((value){
            if(value.isNotEmpty){
          //    User user=User.fromDB(value.first);
              return value.first;
            }

            else{
              return null;}});

          Preferences preferences=Preferences.fromDB(account_map);
          User user=User.fromDB(user_map!);

          preferences.user=user;
          return preferences;

        }

        else{
          return null;
        }


      }

      else{
        return null;
      }
    }
    
    catch(Exception,stacktrace){
      print("Error: " + stacktrace.toString());
      return null;
    }
  }




}