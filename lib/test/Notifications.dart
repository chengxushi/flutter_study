import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// @description
/// @Created by huang
/// @Date   2020/5/25
/// @email  a12162266@163.com

class Notifications extends StatefulWidget {
  @override
  NotificationsState createState() => new NotificationsState();
}

class NotificationsState extends State<Notifications>{
//  FlutterLocalNotificationsPlugin tongZhiLan = FlutterLocalNotificationsPlugin();
//  @override
//  void initState() {
//    super.initState();
//    var androidIcon = AndroidInitializationSettings('icon_app');
//    var iosIcon = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = InitializationSettings(androidIcon, iosIcon);
//    tongZhiLan.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//  }
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
        ],
      ),
    );
  }

  Future _showNotification() async {
    //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
//    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//        'your channel id',
//        'your channel name',
//        'your channel description',
//        importance: Importance.Max,
//        priority: Priority.High,
//        showProgress: true,
//        maxProgress: 100,
//        progress: 50,
//    );
//    //IOS的通知配置
//    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//    var platformChannelSpecifics = new NotificationDetails(
//        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//    //显示通知，其中 0 代表通知的 id，用于区分通知。
//    await tongZhiLan.show(
//        0,
//        'title',
//        'content',
//        platformChannelSpecifics,
//        payload: 'complete');
  }

  Future<void> onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
//              await Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => SecondScreen(payload),
//                ),
//              );
            },
          )
        ],
      ),
    );
  }

  Future<void> onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
  }
  
  @override
  void dispose() {
    super.dispose();
  }
}
