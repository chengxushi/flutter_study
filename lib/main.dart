import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study/common/routers/router_util.dart';
import 'package:flutter_study/common/routers/routers.dart';
import 'package:flutter_study/provider/inherited_widget.dart';
import 'package:flutter_study/test/share_text.dart';
import 'package:flutter_study/test/sqflite_page.dart';
import 'package:flutter_study/test/webview_inapp.dart';
import 'package:flutter_study/tici/autocue_home.dart';
import 'package:flutter_study/tici/maruqee_page.dart';
import 'package:uni_links/uni_links.dart';

import 'camera/camera_page.dart';
import 'douyin/video_home.dart';
import 'provider/provider_state_widget_1.dart';
import 'test/Notifications.dart';
import 'test/android_native.dart';
import 'test/button_my.dart';
import 'test/hero_my.dart';
import 'test/huadongwebview.dart';
import 'test/sliding_up.dart';
import 'test/stream_builder_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  MyApp(){
    //初始化路由管理
    Routers.initRoutes();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Routers.router.generator,
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

enum UniLinksType { string, uri }

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UniLinksType _type = UniLinksType.string;
  StreamSubscription _sub;
  
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  ///  初始化Scheme只使用了String类型的路由跳转
  ///  所以只有一个有需求可以使用[initPlatformStateForUriUniLinks]
  Future<void> initPlatformState() async {
    if (_type == UniLinksType.string) {
      await initPlatformStateForStringUniLinks();
    }
  }

  Future<void> initPlatformStateForStringUniLinks() async {
    String initialLink;
    // App未打开的状态在这个地方捕获scheme
    try {
      initialLink = await getInitialLink();
      print('initial link: $initialLink');
      if (initialLink != null) {
        print('initialLink--$initialLink');
        //  跳转到指定页面
      }
    } on PlatformException {
      initialLink = 'Failed to get initial link.';
    } on FormatException {
      initialLink = 'Failed to parse the initial link as Uri.';
    }
    // App打开的状态监听scheme
    _sub = getLinksStream().listen((String link) {
      if (!mounted || link == null) return;
      print('link--$link');
      //  跳转到指定页面
    }, onError: (Object err) {
      if (!mounted) return;
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_sub != null) _sub.cancel();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: ListView(
        children: <Widget>[
          _item('上拉抽屉', SlidingUP()),
          _item('通知栏', Notifications()),
          _item('状态管理', ProviderState1Widget()),
//          _item('音乐播放器', BoFangAudio()),
          _item('MethodChannel', AndroidNative()),
          _item('ios滑动网页', huadongwebview()),
          _item('数据库', SqflitePage()),
          _item('抖音', VideoHome()),
          _item('提词器', AutocueHome()),
          _item('拍照', CameraPage()),
          _item('字幕', MaruqeePage()),
          _item('inAppWebView的使用', WebViewInApp()),
          _item('StreamBuilder的使用', StreamBuilderPage()),
          _item('分享文本', ShareText()),
          _item('按钮组', ButtonMy()),
          _item('hero动画', CustomHero()),
        ],
      ),
    );
  }
  
  Widget _item(String text, Widget page){
    return OutlineButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      child: Text(text, style: TextStyle(fontSize: 16,),),
    );
  }
}
