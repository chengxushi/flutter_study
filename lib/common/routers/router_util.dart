import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/common/routers/routers.dart';

/// @description  路由跳转类
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class RouterUtil {
  //跳转
  static void push(BuildContext context, String path, {bool replace = false, bool clearStack = false}){
    unfocus();
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }

  //带有返回值的跳转
  static void pushResult(BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}){
    unfocus();
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((Object result){
      // 页面返回result为null
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  // 返回
  static void pop(BuildContext context, {Object result}) {
    unfocus();
    if(result != null){
      Navigator.pop<Object>(context, result);
    } else{
      Routers.router.pop(context);
    }
  }

  //关闭键盘
  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}