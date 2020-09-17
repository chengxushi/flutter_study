import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/tici/marquee.dart';
import 'package:flutter_study/tici/roll_text.dart';
import 'package:flutter_study/tici/timer_text.dart';

/// @description
/// @Created by huang
/// @Date   2020/7/10
/// @email  a12162266@163.com

class AutocueHome extends StatefulWidget {
  @override
  AutocueHomeState createState() => new AutocueHomeState();
}

class AutocueHomeState extends State<AutocueHome> {
  String mString;
  String mString2;
  String mString3;
  RollTextController controller = RollTextController();
  double _textSize = 5;
  double _speed = 0.0;
  double _bgSize = 8;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    mString = '黄1234567890ABCDabcdg  '
        '\n昔人已乘黄鹤去，此地空余黄鹤楼。'
        '\n黄鹤一去不复返，白云千载空悠悠。'
        '\n晴川历历汉阳树，芳草萋萋鹦鹉洲。'
        '\n日暮乡关何处是？烟波江上使人愁。';
    mString2 = '(1)选择超高清拍摄建议手机设备相对来说高配置大内存效果最好'
        '\n(2)拍摄时，台词滚动的中间两行高亮显示,看词更轻松 '
        '\n(3)拍摄完后自动保存相册，也可以分享给微信好友，还可以直接发布到抖音进一步优化 '
        '\n(4)拍摄对手机性能和电量要求高，及时升级手机系统和补充电量 '
        '\n(5)视频特效和滤镜要求的亲们，可以提词即拍拍摄好后再用剪辑软件处理视频效果';
    mString3 = '将进酒'
        '\n李白'
        '\n君不见黄河之水天上来,奔流到海不复回。'
        '\n君不见高堂明镜悲白发,朝如青丝暮成雪。'
        '\n人生得意须尽欢，莫使金樽空对月。'
        '\n天生我材必有用，千金散尽还复来。'
        '\n烹羊宰牛且为乐，会须一饮三百杯。'
        '\n岑夫子，丹丘生，将进酒，杯莫停。'
        '\n与君歌一曲，请君为我倾耳听。'
        '\n钟鼓馔玉不足贵，但愿长醉不复醒。'
        '\n古来圣贤皆寂寞，惟有饮者留其名。'
        '\n陈王昔时宴平乐，斗酒十千恣欢谑。'
        '\n主人何为言少钱，径须沽取对君酌。'
        '\n五花马、千金裘，'
        '\n呼儿将出换美酒，与尔同销万古愁。';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderTheme(
          data: SliderThemeData(
              valueIndicatorColor: Colors.transparent,
              valueIndicatorTextStyle: TextStyle(color: Colors.black, fontSize: 14),
              //气泡显示的形式
              showValueIndicator: ShowValueIndicator.always,
              inactiveTickMarkColor: Colors.transparent),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: RollText(
                    text: mString2,
                    winHeight: MediaQuery.of(context).size.height,
                    winWidth: MediaQuery.of(context).size.width,
                    controller: controller,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Slider(
                  value: _textSize,
                  onChanged: (value) {
                    setState(() {
                      _textSize = value;
                      controller.setTextSize(value);
                    });
                  },
                  onChangeEnd: (value) {
                  
                  },
                  label: '字体${_textSize.toInt()}',
                  min: 0.0,
                  max: 10.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Slider(
                  value: _speed,
                  onChanged: (value) {
                    setState(() {
                      _speed = value;
                    });
                  },
                  onChangeEnd: (value) {
                    controller.setSpeed(value);
                  },
                  label: '速度${_speed}',
                  divisions: 10,
                  min: 0.0,
                  max: 10.0,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Slider(
                  value: _bgSize,
                  onChanged: (value) {
                    setState(() {
                      _bgSize = value;
                    });
                  },
                  onChangeEnd: (value) {
                    controller.setBgSize(value);
                  },
                  label: '背景${_bgSize.toInt()}',
                  divisions: 10,
                  min: 0.0,
                  max: 10.0,
                ),
              ),
              TimerText(),
            ],
          )),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            onPressed: () {
              controller.startScroll();
            },
            icon: Icon(Icons.play_circle_outline),
            iconSize: 40,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                controller.setTextColor(Colors.yellow);
              },
              icon: Icon(Icons.style),
              iconSize: 40,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                controller.setTextSize(30);
              },
              icon: Icon(Icons.format_size),
              iconSize: 40,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () {
                controller.setSpeed(10);
              },
              icon: Icon(Icons.router),
              iconSize: 40,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
