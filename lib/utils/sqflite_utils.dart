import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// @description
/// @Created by huang
/// @Date   2020/6/30
/// @email  a12162266@163.com

class SqfLiteUtils{
  static Database _database;
  static String _userTable = 'user_table'; //用户表名
  static String _dbName = 'db_name.db'; //数据库名
//  static String _dbPath; //数据库地址
  
  static void init() async {
    //获取数据库的默认存储位置
    String databasesPath = await getDatabasesPath();
    //地址的拼接, (不会默认倒入相关库path.dart)
    String dbPath = join(databasesPath, _dbName);
    debugPrint('====数据库的地址: $dbPath');
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // 表格创建等初始化操作
        debugPrint('数据库的初始化');
        await db.execute('CREATE TABLE $_userTable (id INTEGER PRIMARY KEY, name TEXT,age INTEGER)');
        await db.close();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // 数据库升级
        debugPrint('数据库的升级, 旧版：$oldVersion,新版：$newVersion');
      },
    );
  }
  
  //打开
  static void open() async {
    //获取数据库地址
    String databasesPath = await getDatabasesPath();
    //拼接地址
    String path = join(databasesPath, _dbName);
    //打开数据库
    _database = await openDatabase(path);
  }
  
  //增
  static Future<bool> add({@required String table, @required Map<String, dynamic> values}) async {
    if(table == null || table == ''){
      return false;
    }
    if(values == null){
      return false;
    }
    open();
    ///仅可以使用事务对象来进行调用
    await _database.transaction((txn) async {
      //返回最后插入的记录ID
      int count = await txn.insert(table, values);
    });
    await _database.close();
    return true;
  }
  
  //删
  static Future<int> delete({@required String table}) async {
    if(table == null || table == ''){
      return 0;
    }
    open();
    
    //执行删除
    //where为空则会删除表内所有数据
    //返回的count为受到到影响的条目
    int count = await _database.delete(table, where: null);
    //关闭数据库
    await _database.close();
    if(count > 0){
      return count;
    } else {
      return 0;
    }
  }
  
  //改
  static Future<int> update({@required String table, Map<String, dynamic> values}) async {
    if(table == null || table == ''){
      return 0;
    }
    open();
    
    //执行更改
    //table : 表名
    //values : 更改的值
    //where : 条件,
    //whereArgs ; 需要查询的值
    int count = await _database.update(table, values, where: 'name = ?', whereArgs: [values['name']]);
    //关闭数据库
    await _database.close();
    
    if(count > 0){
      return count;
    } else {
      return 0;
    }
  }
  
  //查全部
  static Future<List<Map>> query({@required String table}) async {
    if(table == null || table == ''){
    
    }
    open();
    
    //查询全部
    List<Map> list = await _database.query(table);
    await _database.close();
    return list;
  }
}