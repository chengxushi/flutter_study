import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/8
/// @email  a12162266@163.com

class WebViewInApp extends StatefulWidget {
  @override
  WebViewInAppState createState() => new WebViewInAppState();
}

class WebViewInAppState extends State<WebViewInApp> {
  InAppWebViewController webView;
  bool vis = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('inAppWebView的使用'),),
      body: Visibility(
        visible: vis,
        replacement: Center(child: IconButton(icon: Icon(Icons.error), onPressed: (){
          setState(() {
            vis = true;
          });
          webView.reload();
        }),),
        child: InAppWebView(
          initialUrl: 'https://baidu.com',
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            print('创建视图');
            webView = controller;
          },
          onLoadStart: (InAppWebViewController controller, String url){
            print('开始加载');
            webView.clearCache();
          },
          onLoadStop: (InAppWebViewController controller, String url){
            print('加载结束');
          },
          onLoadError: (InAppWebViewController controller, String url, int code, String message){
            print('====code=$code====message=$message');
            setState(() {
              vis = false;
            });
          },
          onLoadHttpError: (InAppWebViewController controller, String url,
              int statusCode, String description){
            print('====statusCode=$statusCode====description=$description');
          },
        ),
      ),
    );
  }
}