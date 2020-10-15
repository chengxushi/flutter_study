import 'package:flutter/material.dart';
import 'package:flutter_study/provider/demo/user_model.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/14
/// @email  a12162266@163.com

class UserProvider with ChangeNotifier {
  UserModel userModel;
  String name;
  bool isVip;

  UserProvider(this.userModel)
      : name = userModel.name,
        isVip = userModel.isVip;

  void changeName(String name){
    userModel.name = name;
    notifyListeners();
  }
  
  void changeVip(bool value){
    isVip = value;
    notifyListeners();
  }
}