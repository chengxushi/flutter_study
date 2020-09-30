import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/common/routers/routers.dart';

/// @description
/// @Created by huang
/// @Date   2020/8/13
/// @email  a12162266@163.com

class RouterUtil {
  //跳转
  static void push(BuildContext context, String path, {bool replace = false, bool clearStack = false, String param}){
    unFocus();
    if(param != null){
      path = path + analysisParam(param);
    }
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native);
  }
  //带有返回值的跳转
  static void pushResult(BuildContext context, String path,
      {@required Function(Object) function, bool replace = false, bool clearStack = false, String param}){
    unFocus();
    if(param != null){
      path = path + analysisParam(param);
    }
    Routers.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((Object result){
      // 页面返回result为null
      // if (result == null) {
      //   return;
      // }
      function(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }
  // 返回
  static void pop(BuildContext context, {Object result}) {
    if(result != null){
      Navigator.pop<Object>(context, result);
    } else{
      Routers.router.pop(context);
    }
  }
  
  //跳转到网页
  static void pushToWeb(BuildContext context, {@required String url, String title, bool isOpenVip = false}){
    push(
      context,
      Routers.webView,
      param: 'url = $url & title = $title & isOpenVip = ${isOpenVip.toString()}',
    );
  }
  
  //跳转到网页, 有返回值
  static void pushToWebResult(BuildContext context, {@required String url, String title, bool isOpenVip = false, Function(Object) function}){
    pushResult(
      context,
      Routers.webView,
      param: 'url = $url & title = $title & isOpenVip = ${isOpenVip.toString()}',
      function: function,
    );
  }
  
  //参数的解析
  static String analysisParam(String param) {
    const String cutString = '&';
    String res;
    //多个参数的分割
    final List<String> list = param.split(cutString);
    if(list.isNotEmpty){
      for(int index = 0; index < list.length; index++){
        //找到等号的位置
        final int i = list[index].indexOf('=');
        //从0到等号的位置就是参数, 去除左右空格
        final String head = list[index].substring(0, i).trim();
        //从i+1到最后是参数, 去除左右空格
        //fluro 不支持传中文,需转换
        final String tail = Uri.encodeComponent(list[index].substring(i+1, list[index].length).trim());
        //拼接
        if(index != 0){
          res = res + cutString + '$head=$tail';
        } else {
          res = '?$head=$tail';
        }
      }
    }
    return res;
  }
  
  static void unFocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}