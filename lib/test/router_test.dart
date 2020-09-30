import 'package:flutter/material.dart';
import 'package:flutter_study/test/async_test.dart';
import 'package:nav_router/nav_router.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/29
/// @email  a12162266@163.com

class RouterTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          OutlineButton(
            onPressed: (){
              routePush(AsyncTest());
            },
            child: Text('普通跳转'),
          ),
        ],
      ),
    );
  }
}