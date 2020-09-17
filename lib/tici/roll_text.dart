import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/7/10
/// @email  a12162266@163.com

class RollText extends StatefulWidget {
  final String text;
  final int time;
  final int pauseTime;
  final double winHeight;
  final double winWidth;
  final RollTextController controller;

  const RollText({
    Key key,
    @required this.text,
    this.winHeight,
    this.winWidth,
    this.time = 20000,
    this.pauseTime = 500,
    this.controller,
  }) : super(key: key);

  @override
  RollTextState createState() => new RollTextState();
}

class RollTextState extends State<RollText> {
  ScrollController scrollController = ScrollController();
  ///滚动时间
  int _time;
  ///暂停时间
  int _pauseTime;
  ///字体颜色
  Color _textColor;
  ///字体大小
  double _textSize;
  ///背景宽度
  double _bgWidth;
  ///背景高度
  double _bgHeight;
  ///背景透明度
  Color _bgOpacity;
  ///是否可以滑动
  ScrollPhysics _physics;
  ///最大滚动距离
  double _maxScroll;
  ///上间距
  double _marginTop;
  ///下间距
  double _marginBottom;
  ///当前滚动位置
  double offset;

  @override
  void initState() {
    super.initState();
    initData();
    scrollController.addListener(() {
//      if(scrollController.offset >= scrollController.position.maxScrollExtent){
//        if(!scrollController.position.activity.isScrolling){
//          scrollController.jumpTo(0.0);
//        }
//      }
//      debugPrint('最大滚动位置=${scrollController.position.maxScrollExtent}=${scrollController.offset}==');
    
    });
  }

  ///设置初始值
  void initData() {
    _time = widget.time;
    _pauseTime = widget.pauseTime;
    _bgWidth = (widget.winWidth / 10) * 8;
    _bgHeight = 200.0;
    _bgOpacity = Colors.black.withOpacity(0.5);
    _textSize = 20.0;
    _textColor = Colors.white;
    _physics = const ClampingScrollPhysics();
    _marginBottom = _bgHeight;
    _marginTop = _bgHeight / 2;

    ///绑定控制器
    widget.controller?._bind(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _bgHeight,
      width: _bgWidth,
      color: _bgOpacity,
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        physics: _physics,
        child: Container(
          margin: EdgeInsets.only(bottom: _marginBottom, top: _marginTop),
          child: Text(
            widget.text,
//            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.3,
              fontSize: _textSize,
              color: _textColor,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }

  ///开始滚动
  void _startScroll() async {
    _maxScroll = scrollController.position.maxScrollExtent;
    scrollController.jumpTo(0.0);
    debugPrint('===运行时间=$_time');
    debugPrint('===_maxScroll=$_maxScroll');
    await scrollController.animateTo(_maxScroll,
        duration: Duration(milliseconds: _time), curve: Curves.linear);
    await Future.delayed(Duration(milliseconds: _pauseTime)).then((value) {
      scrollController.jumpTo(0.0);
      setState(() {
        _physics = const ClampingScrollPhysics();
//        _marginTop = 0;
      });
    });
  }

  ///设置背景大小
  void _setBgSize(double ratio) {
    if (ratio <= 0) ratio = 1.0;
    setState(() {
      _bgWidth = (widget.winWidth / 10) * ratio;
    });
  }

  ///设置背景透明度
  void _setBgOpacity(double opacity) {
    opacity = opacity * 0.1;
    setState(() {
      _bgOpacity = Colors.black.withOpacity(opacity);
    });
  }

  ///设置字体颜色
  void _setTextColor(Color color) {
    setState(() {
      _textColor = color;
    });
  }

  ///设置字体大小
  void _setTextSize(double size) {
    setState(() {
      _textSize = 10 + 3 * size;
    });
    debugPrint('==字体大小=$_textSize');
  }

  ///设置滚动速度
  void _setSpeed(double speed) {
//    double time = widget.text.length / 3 - 5 * speed;
    _maxScroll = scrollController.position.maxScrollExtent;
    double max = _maxScroll - 10;
    double time = max / (_textSize * 1.3) * (_computeSpeed(speed.round())) * 1.3;
    
    debugPrint('===max= $max==时间 = ${time.ceil()}');
    _time = ((time <= 0 ? 5 : time) * 1000).ceil();
    _keepScroll(allTime: time, maxScroll: _maxScroll);
  }
  
  void _keepScroll({double allTime, double maxScroll}) async {
    if(_physics != NeverScrollableScrollPhysics()){
      setState(() {
        _physics = const NeverScrollableScrollPhysics();
      });
    }
    ///已滚动距离
    double offset = scrollController.offset;
    ///已用时间
    double yetTime = (allTime / maxScroll) * offset;
    ///剩余时间
    int remainingTime = ((allTime - yetTime) * 1000).ceil();
    print('=总时间=$allTime=已用时间=$yetTime=剩余时间=$remainingTime');
    await scrollController.animateTo(maxScroll,
        duration: Duration(milliseconds: remainingTime), curve: Curves.linear).then((value){
          if(scrollController.offset >= scrollController.position.maxScrollExtent){
            scrollController.jumpTo(0.0);
          }
    });
  }

  int _computeSpeed(int speed) {
    switch (speed) {
      case 10:
        return 1;
      case 9:
        return 2;
      case 8:
        return 3;
      case 7:
        return 4;
      case 6:
        return 5;
      case 5:
        return 6;
      case 4:
        return 7;
      case 3:
        return 8;
      case 2:
        return 9;
      case 1:
        return 10;
      case 0:
        return 10;
      default:
        return 5;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class RollTextController {
  RollTextState _rollTextState;

  void _bind(RollTextState rollTextState) {
    this._rollTextState = rollTextState;
  }

  ///开始滚动
  void startScroll() {
    _rollTextState._startScroll();
  }
  ///背景大小
  void setBgSize(double ratio) {
    _rollTextState._setBgSize(ratio);
  }
  ///背景透明度
  void setBgOpacity(double opacity) {
    _rollTextState._setBgOpacity(opacity);
  }
  ///字体颜色
  void setTextColor(Color color) {
    _rollTextState._setTextColor(color);
  }
  ///字体大小
  void setTextSize(double size) {
    _rollTextState._setTextSize(size);
  }
  ///滚动速度
  void setSpeed(double speed) {
    _rollTextState._setSpeed(speed);
  }
}
