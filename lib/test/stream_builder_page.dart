import 'dart:async';

import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/9
/// @email  a12162266@163.com

class StreamBuilderPage extends StatefulWidget {
  @override
  StreamBuilderPageState createState() => new StreamBuilderPageState();
}

class StreamBuilderPageState extends State<StreamBuilderPage> {
  StreamController _key1Stream = StreamController<int>();
  StreamSink<int> get streamSink => _key1Stream.sink;
  Stream<int> get streamData => _key1Stream.stream;
  int key1 = 0;

  @override
  void initState() {
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();
    _key1Stream.close();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          OutlineButton(
            onPressed: (){
              streamSink.add(key1++);
            },
            child: Text('改变1值'),
          ),
          StreamBuilder(
            stream: _key1Stream.stream,
            builder: (context, snapshot){
              return Text('1的值为: ${snapshot.data}');
            },
          ),
        ],
      ),
    );
  }
}