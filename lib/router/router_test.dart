import 'package:flutter/material.dart';
import 'package:flutter_study/moments/detail_model.dart';

import 'flutter_study_routes.dart';

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
              Navigator.pushNamed(context, Routes.routerNotArg);
            },
            child: Text('普通跳转'),
          ),
          OutlineButton(
            onPressed: (){
              Navigator.pushNamed(context, Routes.routerArg, arguments: <String, dynamic>{
                'value': 2,
                'text': '这是字符串',
                'avsModel': Avs(createTime: '时间', id: 2),
              },);
            },
            child: Text('带参跳转'),
          ),
          OutlineButton(
            onPressed: (){
              Navigator.pushNamed(context, Routes.routeNew,);
            },
            child: Text('新建路由'),
          ),
        ],
      ),
    );
  }
}