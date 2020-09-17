import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @description  Flutter调用安卓原生代码
/// @Created by huang
/// @Date   2020/5/28
/// @email  a12162266@163.com

class AndroidNative extends StatefulWidget {
  @override
  AndroidNativeState createState() => new AndroidNativeState();
}

class AndroidNativeState extends State<AndroidNative> {
  //方法名
  static const MethodChannel  _platform = const MethodChannel("plugin.channel.data");
  
  //创建 BasicMessageChannel
  // flutter_and_native_100 为通信标识
  // StandardMessageCodec() 为参数传递的 编码方式
  static const messageChannel = const BasicMessageChannel('flutter_and_native_100', StandardMessageCodec());
  String resultData = "No data";
  String recive = "No data";
  String callbackData = "No data";

  getSharedText() async {
    final Map<String, dynamic> params = <String, dynamic>{
      'text': 'flutter发送到安卓的数据',
      'num': 1,
    };
    var sharedData = await _platform.invokeMethod("send", params);
    if (sharedData != null) {
      setState(() {
        callbackData = sharedData.toString();
      });
    }
  }

  //发送消息
  Future<Map> sendMessage(Map arguments) async {
    Map reply = await messageChannel.send(arguments);
    //解析 原生发给 Flutter 的参数
    int code = reply["code"];
    String message = reply["message"];
  
    //更新 Flutter 中页面显示
    setState(() {
      resultData = "code:$code message:$message";
    });
    return reply;
  }

  //接收消息监听
  void receiveMessage() {
    messageChannel.setMessageHandler((result) async {
      //解析 原生发给 Flutter 的参数
      int code = result["code"];
      String message = result["message"];
    
      setState(() {
        recive = "receiveMessage: code:$code message:$message";
      });
      return 'Flutter 已收到消息';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MethodChannel'),),
      body: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: () => getSharedText(),
            child: Text('回调数据'+callbackData),
          ),
          OutlineButton(
            onPressed: () {
              //Flutter 向 Android iOS 中基本的发送消息方式
              sendMessage({"method": "test", "content": "flutter 传输过来的数据", "code": 100});
            },
            child: Text('test==='+resultData),
          ),
          OutlineButton(
            onPressed: () {
              //用来实现 Android iOS 主动触发 向 Flutter 中发送消息
              sendMessage({"method": "test2", "content": "flutter 中的数据", "code": 100});
            },
            child: Text('test2==='+recive),
          ),
          OutlineButton(
            onPressed: () {
              //用来实现 Flutter 打开 Android iOS 中的一个新的页面
              sendMessage({"method": "test3", "content": "flutter 中的数据", "code": 100});
            },
            child: Text('test3==='+resultData),
          ),
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.amberAccent,
            child: AndroidView(viewType: 'android_view'),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    //注册消息监听, 接收Android端主动发过来的消息
    receiveMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }
}