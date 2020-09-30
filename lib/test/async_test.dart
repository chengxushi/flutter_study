import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/25
/// @email  a12162266@163.com

class AsyncTest extends StatefulWidget {
  @override
  _AsyncTestState createState() => _AsyncTestState();
}

class _AsyncTestState extends State<AsyncTest> {
  String text = '初始值';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          children: [
            Center(
              child: OutlineButton(
                onPressed: (){
                  // text = '初始值';
                  // add1().then((value){print('111111111');});
                  // add2().then((value){print('2222');});
                  // add3();
                  Map<dynamic, dynamic> maps = Map();
                  maps.addAll({'123': 2});
                  Map<String, dynamic> map2 = Map();
                  var map3 = maps as Map<String, dynamic>;
                  print(map3.runtimeType);
                },
                child: Text('点击'),
              ),
            ),
            Center(
              child: OutlineButton(
                onPressed: (){
                  text = '初始值';
                  add1().then((value){
                    add2().then((value){
                      add3();
                    });
                  });
                },
                child: Text('点击2'),
              ),
            ),
            Center(
              child: OutlineButton(
                onPressed: (){
                  text = '初始值';
                  add2();
                  add5();
                  add3();
                },
                child: Text('点击3'),
              ),
            ),
            Center(
              child: OutlineButton(
                onPressed: () async {
                  text = '初始值';
                  text = await add6();
                  print('点击1:  '+text);
                  text = text + await add7();
                  print('点击2:  '+text);
                },
                child: Text('点击4'),
              ),
            ),
            OutlineButton(
              onPressed: () async {
                text = '初始值';
                text = await add6();
                print('点击1:  '+text);
                text = text + await add7();
                print('点击2:  '+text);
              },
              child: Text('点击4'),
            ),
          ],
      ),
    );
  }

  Future<void> add1() async {
    print('add1:  1 ');
     Future.delayed(Duration(seconds: 2), (){
  
       text = text + '=第一=';
       print('add1:   '+text);
    }).then((value){
    });
    print('add1:  2 ');
  }

  
  Future<void> add2() async {
    print('add2:  3 ');
     Future.delayed(Duration(microseconds: 1), (){
  
       text = text + '=第二=';
       print('add2:   '+text);
    }).then((value){
    }).whenComplete(() => null);
    print('add2:  4 ');
  }

  void add3() {
    text = text + '=第三=';
    print('同步:   '+text);
  }

  Future<void> add4() async {
    await Future.delayed(Duration(seconds: 4), (){
      text = text + '=第四=';
      print('add4:   '+text);
    });
  }
  
  Future<void> add5() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(packageInfo.buildNumber == '1'){
      text = text + '=第五--真值=';
      print('add5--真值:   '+text);
    } else {
      text = text + '=第五--否值=';
      print('add5--否值:   '+text);
    }
    add3();
    text = text + '=第五--外值=';
    print('add5--外值:   '+text);
  }

  Future<String> add6() async {
    Future.delayed(Duration(seconds: 3), (){
      text = text + '=第六--里值=';
      print('add6:   '+text);
      return '里值';
    });
    return '外值';
  }

  Future<String> add7() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(packageInfo.buildNumber == '1'){
      return packageInfo.buildNumber + '真值';
      // bool v = await add8();
      // if(v){
      //   print('真值: true');
      //   return packageInfo.buildNumber + '真值';
      // } else {
      //   print('假值: false');
      //   return packageInfo.buildNumber + '假值';
      // }
    }
    print('add7:   ');
    return packageInfo.buildNumber + '直接返回值';
  }

  Future<bool> add8() async {
    Future.delayed(Duration(seconds: 3), (){
    }).then((value){
      print('true');
      return true;
    });
    print('false');
    return false;
  }
}