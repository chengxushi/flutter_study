import 'package:flutter/material.dart';
import 'package:flutter_study/utils/sqflite_utils.dart';

/// @description
/// @Created by huang
/// @Date   2020/6/30
/// @email  a12162266@163.com

class DatabaseTest extends StatefulWidget {
  @override
  DatabaseTestState createState() => new DatabaseTestState();
}

class DatabaseTestState extends State<DatabaseTest> {
  TextEditingController _nameController=new TextEditingController();
  TextEditingController _ageController=new TextEditingController();
  String _data = "暂无数据";
  
  @override
  void initState() {
    super.initState();
    SqfLiteUtils.init();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

  @override
  void dispose() {
    super.dispose();
  }
}