import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/6/11
/// @email  a12162266@163.com

class ScrollingList extends StatefulWidget {
  final ScrollController sc;

  ScrollingList(this.sc);

  @override
  ScrollingListState createState() => new ScrollingListState();
}

class ScrollingListState extends State<ScrollingList> {
  bool up = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: widget.sc,
        shrinkWrap: true,
        itemExtent: 500,
//      physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
//        Text('白日依山尽', style: TextStyle(fontSize: 20, color: Colors.black,),),
//        Text('白日依山尽', style: TextStyle(fontSize: 20, color: Colors.black,),),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}