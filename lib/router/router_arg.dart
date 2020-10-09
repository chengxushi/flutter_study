import 'package:flutter/material.dart';
import 'package:flutter_study/moments/detail_model.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/30
/// @email  a12162266@163.com

@FFRoute(
  name: '/routerArg',
  routeName: 'RouterArg',
  argumentImports: <String>[
    'import \'package:flutter_study/moments/detail_model.dart\';',
  ],
)
class RouterArg extends StatefulWidget {
  
  const RouterArg({Key key, this.value, this.text, this.avsModel}) : super(key: key);
  
  final int value;
  final String text;
  final Avs avsModel;
  
  @override
  RouterArgState createState() => RouterArgState();
}

class RouterArgState extends State<RouterArg> {

  @override
  void initState() {
    super.initState();
    print(widget.value);
    print(widget.text);
    print(widget.avsModel.createTime);
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}