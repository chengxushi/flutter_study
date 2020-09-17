import 'package:flutter/foundation.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class TestModel with ChangeNotifier {
  int modelValue;
  int modelValue2;

  int get value => modelValue;
  int get value2 => modelValue2;

  TestModel({this.modelValue = 0, this.modelValue2 = 0});

  void add(){
    modelValue++;
    notifyListeners();
  }
  void add2(){
    modelValue2++;
    notifyListeners();
  }
}