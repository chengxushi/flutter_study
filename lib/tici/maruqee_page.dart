import 'package:flutter/material.dart';

import 'marquee.dart';

/// @description
/// @Created by huang
/// @Date   2020/8/31
/// @email  a12162266@163.com

class MaruqeePage extends StatefulWidget {
  @override
  MaruqeePageState createState() => new MaruqeePageState();
}

class MaruqeePageState extends State<MaruqeePage> {
String mString2;
  @override
  void initState() {
    super.initState();

    mString2 = '(1)选择超高清拍摄建议手机设备相对来说高配置大内存效果最好'
        '\n(2)拍摄时，台词滚动的中间两行高亮显示,看词更轻松 '
        '\n(3)拍摄完后自动保存相册，也可以分享给微信好友，还可以直接发布到抖音进一步优化 '
        '\n(4)拍摄对手机性能和电量要求高，及时升级手机系统和补充电量 '
        '\n(5)视频特效和滤镜要求的亲们，可以提词即拍拍摄好后再用剪辑软件处理视频效果';
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Marquee(
          text: mString2,
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          blankSpace: 20.0,
          velocity: 50,
          pauseAfterRound: Duration(seconds: 1),
          showFadingOnlyWhenScrolling: true,
          fadingEdgeStartFraction: 0.1,
          fadingEdgeEndFraction: 0.1,
          numberOfRounds: 1,
          startPadding: 10.0,
          accelerationCurve: Curves.linear,
          decelerationDuration: Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}