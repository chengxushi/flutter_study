import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/4/9
/// @email  a12162266@163.com

class ViewPlay extends StatefulWidget {
  final int onclick;
  
  ViewPlay({this.onclick = 0});
  
  @override
  ViewPlayState createState() => new ViewPlayState();
}

class ViewPlayState extends State<ViewPlay> {
  final FijkPlayer player = FijkPlayer();
  
  @override
  void initState() {
    super.initState();
    player.setDataSource(
        'https://stream7.iqilu.com/10339/upload_transcode/202002/18/20200218114723HDu3hhxqIT.mp4',
        autoPlay: false,
      showCover: true
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => widget.onclick == 0 ? Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPlay(onclick: 1,))) : Navigator.pop(context),
        child: Center(
          child: FijkView(player: player),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    super.dispose();
    player.release();
  }
}