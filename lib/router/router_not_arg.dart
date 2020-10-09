import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/30
/// @email  a12162266@163.com

@FFRoute(
  name: '/routerNotArg',
  routeName: 'RouterNotArg',
)

class RouterNotArg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('没有参数的注解路由跳转'),
      ),
    );
  }
}