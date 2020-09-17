import 'dart:async';

import 'package:flutter/material.dart';

/// @description 
/// @Created by huang
/// @Date   2020/9/1
/// @email  a12162266@163.com

class TimerText extends StatefulWidget {
  @override
  TimerTextState createState() => new TimerTextState();
}

class TimerTextState extends State<TimerText> {
  String _hours = '00';
  String _minute = '00';
  String _seconds = '00';
  Timer _timer;
  int _count = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  
  startTimer(){
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      print('===${timer.tick}');
      
    });
  }
  
  String changeTime(int time){
    if(time > 0 && time < 60){
      _seconds = time.toString();
    } else if(time >= 60 && time < 3600){
      _minute = (time / 60).toString();
      _seconds = (time % 60).toString();
    } else if(time >= 3600){
      _hours = (time / 3600).toString();
      _minute = (time % 60 / 60).toString();
      _seconds = (time % 60 % 60).toString();
    }

    return '$_hours:$_minute:$_seconds';
  }

  @override
  void dispose() {
    if(_timer != null){
      if(_timer.isActive){
        _timer.cancel();
      }
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Text(
    '_text',
      style: TextStyle(
        color: Colors.white,
        fontSize: 17,
      ),
    );
  }
}