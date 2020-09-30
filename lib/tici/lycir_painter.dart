import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/24
/// @email  a12162266@163.com

class LyricPainter extends CustomPainter {
  final String text;
  
  // List<TextPainter> lyricPainter;
  // TextPainter _highlightPainter = TextPainter(textDirection: TextDirection.ltr);
  // double _offsetY;


  LyricPainter(this.text,);
  @override
  void paint(Canvas canvas, Size size) {
    //画棋盘背景
    var paint = Paint()
      ..isAntiAlias = true //是否抗锯齿
      ..style = PaintingStyle.fill //填充
      ..color = Color(0x77cdb199); //背景为纸黄色
    canvas.drawRect(Offset.zero & size, paint);

    //画中线
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.lightBlueAccent
      ..strokeWidth = 0.5;

    canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height), paint);
    canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);

    TextPainter testHeight = TextPainter(
      text: TextSpan(text: text.substring(0, 2), style: TextStyle(fontSize: 16, color: Colors.black)),
      textDirection: TextDirection.ltr,
    );
    testHeight.layout(maxWidth: size.width);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          TextSpan(
            text: '喝喝喝',
            style: TextStyle(fontSize: 16, color: Colors.yellow),
          ),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: size.width);
    double y = size.height / 2 - textPainter.height / 2;
    textPainter.paint(canvas, Offset(0, y));
    List<LineMetrics> lines = textPainter.computeLineMetrics();
    print('=====${lines.length}==${lines[0]}===');
    TextPainter highlightPainter = TextPainter(
      text: TextSpan(text: text.substring(0, 2), style: TextStyle(fontSize: 16, color: Colors.yellow), ),
      textDirection: TextDirection.ltr,
    );
    highlightPainter.layout(maxWidth: size.width);
    highlightPainter.paint(canvas, Offset(0, y));
  }

  //在实际场景中正确利用此回调可以避免重绘开销，本示例我们简单的返回true
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class LyricContent {
  // static const LineSplitter _splitter = const LineSplitter();
}