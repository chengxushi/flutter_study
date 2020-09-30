import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/common/routers/router_provider.dart';

import '../../main.dart';
/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class Routers {
  static final Router router = Router();
  static final String home = '/home';
  static const String webView = '/webView';
  static final List<RouterProvider> _listRouter = [];
  
  static void initRoutes(){
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params){
          debugPrint('找不到路由, 404');
          return ;
        }
    );
    
    //路由页面配置
    // 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是转场动画
    router.define(home, handler: Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params){
        return HomePage();
      },
    ));
    
    _listRouter.clear();
    /// 各自路由由各自模块管理，统一在此添加初始化
//    _listRouter.add();
    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}

