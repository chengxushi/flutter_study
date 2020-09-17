
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';

import 'video.dart';

// class VideoInfo {
//   final String url;
//   final String title;

//   VideoInfo(this.url, this.title);
// }

class VideoListController {
  /// 构造方法
  VideoListController();

  /// 捕捉滑动，实现翻页
  void setPageController(PageController pageController) {
//    pageController.addListener(() {
//      var p = pageController.page;
//      print('==========pageController.page======$p');
//      if (p % 1 == 0) {
//        //当前pageView的序号
//        int target = p ~/ 1;
//        if (index.value == target) return;
//        // 播放当前的，暂停其他的
//        var oldIndex = index.value;
//        var newIndex = target;
//        playerOfIndex(oldIndex).pause();
//        playerOfIndex(oldIndex).seekTo(0);
//        playerOfIndex(newIndex).start();
//        // 完成
//        index.value = target;
//      }
//    });
  }

  /// 在当前的list后面继续增加视频，并预加载封面
  addVideoInfo(List<UserVideo> list, int playIndex) {
    for (int i = 0; i < list.length; i++) {
      playerList.add(
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
  
  /// 初始化
  init(PageController pageController, List<UserVideo> initialList, int playIndex) {
    addVideoInfo(initialList, playIndex);
    setPageController(pageController);
    index.value = playIndex;
  }

  /// 目前的视频序号
  ValueNotifier<int> index = ValueNotifier<int>(0);

  /// 视频列表
  List<FijkPlayer> playerList = [];

  ///
  FijkPlayer get currentPlayer => playerList[index.value];

  bool get isPlaying => currentPlayer.state == FijkState.started;
  
  int get viewIndex => index.value;

  /// 获取指定index的player
  FijkPlayer playerOfIndex(int index) => playerList[index];

  /// 视频总数目
  int get videoCount => playerList.length;
  
  //type: 0为添加下一条 1为添加上一条
  void addVideoPlay(UserVideo userVideo, int type){
    if(type == 0){
      playerList.add(
        FijkPlayer()
          ..setDataSource(
            userVideo.url,
            autoPlay: false,
            showCover: true,
          )
          ..setLoop(0),
      );
    }else if(type == 1){
      playerList.insert(0,
        FijkPlayer()
          ..setDataSource(
            userVideo.url,
            autoPlay: false,
            showCover: true,
          )
          ..setLoop(0),
      );
    }
  }
  
  void deleteVideoPlay(int index){
    playerOfIndex(index).release();
    playerList.removeAt(index);
  }
  
  /// 销毁全部
  void dispose() {
    // 销毁全部
    for (var player in playerList) {
//      player.dispose();
      player.release();
    }
    playerList = [];
  }
}
