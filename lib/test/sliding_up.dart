import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer_webview.dart';

/// @description
/// @Created by huang
/// @Date   2020/5/25
/// @email  a12162266@163.com

class SlidingUP extends StatefulWidget {
  @override
  SlidingUPState createState() => new SlidingUPState();
}

class SlidingUPState extends State<SlidingUP> {
  bool _isTop = true;
  
  @override
  void initState() {
    super.initState();
//    EventBusUtils.on<UserInfoRefreshEvent>((event) {
//      setState(() {
//        _isTop = event.isTop;
//      });
//    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
          panelBuilder: Center(),
          url: 'https://www.yuque.com/xytech/flutter',
          maxHeight: 580,
          isDraggable: true,
          body: GestureDetector(
            onTap: (){
              print('点击了第二层');
            },
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 30,
                      child: GestureDetector(
                        onTap: (){
                          print('点击第二层');
                          
                        },
                        child: Container(
                          height: 300,
                          width: 300,
                          color: Colors.green,
                        ),
                      )),
                  Positioned(
                      top: 30,
                      child:IgnorePointer(
                        child: GestureDetector(
                          onTap: (){
                            print('点击第一层');
                          },
                          child:  Container(
                            height: 150,
                            width: 150,
                            color: Colors.black,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )
      ),
    );
  }
}