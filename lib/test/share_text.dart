import 'package:flutter/material.dart';
import 'package:share/share.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/15
/// @email  a12162266@163.com

class ShareText extends StatefulWidget {
  @override
  ShareTextState createState() => new ShareTextState();
}

class ShareTextState extends State<ShareText> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = '长河落日圆';
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: controller,
            ),
            RaisedButton.icon(
              onPressed: (){
                Share.share(controller.text);
              },
              icon: Icon(Icons.mobile_screen_share),
              label: Text('分享'),
            ),
          ],
        ),
      ),
    );
  }
}