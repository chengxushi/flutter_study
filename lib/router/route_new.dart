import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/9
/// @email  a12162266@163.com

@FFRoute(
  name: '/routeNew',
  showStatusBar: false,
)

class RouteNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text('新建路由'),),
    );
  }
}