import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/douyin/video.dart';

/// @description 
/// @Created by huang
/// @Date   2020/10/14
/// @email  a12162266@163.com

class TikTokHome extends StatefulWidget {
  @override
  TikTokHomeState createState() => TikTokHomeState();
}

class TikTokHomeState extends State<TikTokHome> {
  List<String> _imageList = ['assets/images/pic_1.jpg', 'assets/images/pic_2.jpg', 'assets/images/pic_3.jpg', ];
  PageController _pageController = PageController();
  List<UserVideo> videoDataList = [];
  /// 视频列表
  List<FijkPlayer> _playerList = [];
  int _lastReportedPage = 0;
  bool isAdd = false;
  
  @override
  void initState() {
    super.initState();
    videoDataList = UserVideo.fetchVideo();
    addVideoInfo(videoDataList, 0);
    _pageController.addListener(playListener);
  }
  
  void playListener() {
    final int currentPage = _pageController.page.floor();
    if(currentPage != _lastReportedPage){
      FijkValue value = _playerList[currentPage].value;
      if(value.state != FijkState.end){
        _playerList[_lastReportedPage].pause();
        _playerList[_lastReportedPage].seekTo(0);
        _playerList[currentPage].start();
        _lastReportedPage = currentPage;
      } else {
        _playerList[0] = FijkPlayer()..setDataSource(mV1, autoPlay: true, showCover: true,)..setLoop(0);
      }
    }
    if(!isAdd){
      if(_lastReportedPage == 2){
        setState(() {
          print('添加视频');
          _playerList.add(
            FijkPlayer()..setDataSource(mV5, autoPlay: false, showCover: true,)..setLoop(0),
          );
        });
        isAdd = true;
        _playerList[0].release();
      }
    }
  }
  
  @override
  void dispose() {
    _pageController?.removeListener(playListener);
    _pageController?.dispose();
    if(_playerList.isNotEmpty){
      print('==_playerList.length=${_playerList.length}');
      for(final FijkPlayer player in _playerList){
        print('===销毁');
        player?.release();
      }
    }
    super.dispose();
  }

  /// 在当前的list后面继续增加视频，并预加载封面
  void addVideoInfo(List<UserVideo> list, int playIndex) {
    for (int i = 0; i < list.length; i++) {
      _playerList.add(
        FijkPlayer()
          ..setDataSource(
            list[i].url,
            autoPlay: i == playIndex,
            showCover: true,
          )
          ..setLoop(0),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Container(
          // height: 400,
          // width: 300,
          color: Colors.white,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _playerList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: FijkView(
                  player: _playerList[index],
                  color: Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}