import 'dart:collection';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/tici/lycir_painter.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/24
/// @email  a12162266@163.com

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomPaint(
              size: Size(350, 350), //指定画布大小
              painter: MyPainter(),
            ),
            CustomPaint(
              size: Size(350, 350), //指定画布大小
              painter: LyricPainter('锄禾日当午, 汗滴禾下土锄禾日当午 汗滴禾下土。锄禾日当午, 汗滴禾下土。锄禾日当午。\n锄禾日当午, 汗滴禾下土。 '),
    ),
            Image(image: AssetImage('assets/images/pic_1.png'), fit: BoxFit.fitWidth, width: double.infinity,)
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;
    
    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true //是否抗锯齿
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb175); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);
    
    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black87
      ..strokeWidth = 1.0;
    
    //画横线
    for (int i = 0; i <= 15; i++) {
      double dy = eHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    //画竖线
    for (int i = 0; i <= 15; ++i) {
      double dx = eWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
    
    //画中线
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 1.0;
    
    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
    
    //画一个黑子
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
      Offset(size.width / 2 - eWidth / 2, size.height / 2 + eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(size.width / 2 + eWidth / 2, size.height / 2 + eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
  }
  
  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}