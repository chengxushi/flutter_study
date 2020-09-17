import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'custom_fijk_panel.dart';
import 'tikTokVideo.dart';
import 'tikTokVideoPlayer.dart';
import 'video.dart';

/// @description
/// @Created by huang
/// @Date   2020/7/2
/// @email  a12162266@163.com

class DouYinPage extends StatefulWidget {
  final int index;
  final List<UserVideo> videoDataList;
  
  DouYinPage(this.index, this.videoDataList);

  @override
  DouYinPageState createState() => new DouYinPageState();
}

class DouYinPageState extends State<DouYinPage>  with WidgetsBindingObserver{
  
  PageController _pageController;
  SwiperController _swiperController;
  VideoListController _videoListController = VideoListController();
  List<UserVideo> videoList = [];
  bool _hidePauseIcon = true; //是否显示暂停图标
  int maxValue = 3; //最大的播放数量
  int playIndex; //播放视频的下标
  int targetVideoIndex;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed) {
      _videoListController.currentPlayer.pause();
    }
  }
  
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    addVideo();
    targetVideoIndex = widget.index;
    _pageController = PageController(initialPage: playIndex);
//    _swiperController = SwiperController();
    _videoListController.init(
        _pageController,
      videoList,
      playIndex
    );
    _pageController.addListener(() {
      var p = _pageController.page;
      print('==========pageController.page======$p');
      if (p % 1 == 0) {
        //当前pageView的序号
        int target = p ~/ 1;
        if (_videoListController.index.value == target) return;
        // 播放当前的，暂停其他的
        var oldIndex = _videoListController.index.value;
        var newIndex = target;
        _videoListController.playerOfIndex(oldIndex).pause();
        _videoListController.playerOfIndex(oldIndex).seekTo(0);
        _videoListController.playerOfIndex(newIndex).start();
        // 完成
        _videoListController.index.value = target;

        //预加载下下一个
        if (target > oldIndex) {
          targetVideoIndex = targetVideoIndex + 1;
          print('==1========预加载下下一个==target=$target ======widget.videoDataList.length=${widget.videoDataList.length}===targetVideoIndex=$targetVideoIndex');
          if (targetVideoIndex + 1 < widget.videoDataList.length) {
            print('==2========预加载下下一个===');
            videoList.add(widget.videoDataList[targetVideoIndex + 1]);
            _videoListController.addVideoPlay(widget.videoDataList[targetVideoIndex + 1], 0);
//            if (_videoListController.videoCount > 5) {
//              print('==3========预加载下下一个===');
//              videoList.removeAt(0);
//              _videoListController.deleteVideoPlay(0);
//            }
            setState(() {});
            print('==End========预加载下下一个===');
            return;
          }
        }
        
        //预加载上上一个
//        if (target < oldIndex) {
//          targetVideoIndex = targetVideoIndex - 1;
//          print('==1========预加载上上一个==target=$target ======widget.videoDataList.length=${widget.videoDataList.length}===targetVideoIndex=$targetVideoIndex');
//          if (targetVideoIndex - 1 >= 0) {
//            print('==2========预加载上上一个===');
//            videoList.insert(0, widget.videoDataList[targetVideoIndex - 1]);
//            _videoListController.addVideoPlay(widget.videoDataList[targetVideoIndex - 1], 1);
//            if (_videoListController.viewIndex > 5) {
//              _videoListController.deleteVideoPlay(
//                  _videoListController.playerList.length - 1);
//            }
//            _pageController.jumpToPage(target + 1);
////            _pageController.animateToPage(target + 1, duration: Duration(milliseconds: 300), curve: Curves.ease);
//            setState(() {});
//            print('==End========预加载上上一个===');
//            return;
//          }
//        }
      }
    });
    
    super.initState();
  }
  
  addVideo(){
    print('=====widget.index==${widget.index}');
    print('=====widget.videoDataList.length==${widget.videoDataList.length}');
    for(int i = 0; i <= widget.index; i++){
      videoList.add(widget.videoDataList[i]);
    }
    if(widget.index +1 <= widget.videoDataList.length - 1){
      videoList.add(widget.videoDataList[widget.index + 1]);
    }
    playIndex = widget.index;
//    if(widget.index == 0){
//      if(widget.videoDataList.length <= maxValue - 1){
//        widget.videoDataList.forEach((item) {
//          videoList.add(item);
//        });
//      } else{
//        for(int i = 0; i < maxValue - 1; i++){
//          videoList.add(widget.videoDataList[i]);
//        }
//      }
//      playIndex = widget.index;
//    } else if(widget.index > 0 && widget.index == widget.videoDataList.length - 1){
//      for(int i = widget.index; i >= widget.videoDataList.length - maxValue && i >= 0; i--){
//        videoList.add(widget.videoDataList[i]);
//      }
//      List<UserVideo> list = videoList.reversed.toList();
//      videoList.clear();
//      videoList = list;
//      playIndex = maxValue-1;
//    } else {
//      if(widget.index-1 >= 0){
//        videoList.add(widget.videoDataList[widget.index-1]);
//      }
//      for(){
//
//      }
//      videoList.add(widget.videoDataList[widget.index]);
//
//      if(widget.index+1 < widget.videoDataList.length){
//        videoList.add(widget.videoDataList[widget.index+1]);
//      }
//      playIndex = maxValue ~/ 3;
//    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            key: Key('home'),
            controller: _pageController,
            pageSnapping: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: videoList.length,
            itemBuilder: (context, i) {
              // 拼一个视频组件出来
              var data = videoList[i];
//              bool isF = SafeMap(favoriteMap)[i].boolean ?? false;
              var player = _videoListController.playerOfIndex(i);
              
//              // 右侧按钮列
//              Widget buttons = TikTokButtonColumn(
//                isFavorite: isF,
//                onAvatar: () {
//                  tkController.animateToPage(TikTokPagePositon.right);
//                },
//                onFavorite: () {
//                  setState(() {
//                    favoriteMap[i] = !isF;
//                  });
//                  // showAboutDialog(context: context);
//                },
//                onComment: () {
//                  CustomBottomSheet.showModalBottomSheet(
//                    backgroundColor: Colors.white.withOpacity(0),
//                    context: context,
//                    builder: (BuildContext context) =>
//                        TikTokCommentBottomSheet(),
//                  );
//                },
//                onShare: () {},
//              );
              // video
              Widget currentVideo = Center(
                child: FijkView(
                  player: player,
                  color: Colors.black,
                  panelBuilder: customFijkPanelBuilder(
                    onBack: (){
                      Navigator.pop(context);
                    }
                  ),
                ),
              );
        
              currentVideo = TikTokVideoPage(
                hidePauseIcon: _hidePauseIcon,
                aspectRatio: 9 / 17.0,
                key: Key(data.url + '$i'),
                tag: data.url,
                bottomPadding: 0,
                userInfoWidget: VideoUserInfo(
                  desc: data.desc,
                  bottomPadding: 16,
                  // onGoodGift: () => showDialog(
                  //   context: context,
                  //   builder: (_) => FreeGiftDialog(),
                  // ),
                ),
                onSingleTap: () async {
                  if (player.state == FijkState.started) {
                    player.pause();
//                    _hidePauseIcon = false;
                  } else {
                    player.start();
//                    _hidePauseIcon = true;
                  }
                  setState(() {
                  });
                },
                onAddFavorite: () {
//                  setState(() {
//                    favoriteMap[i] = true;
//                  });
                },
                rightButtonColumn: null,
                video: currentVideo,
              );
              return currentVideo;
            },
          ),
//          Opacity(
//            opacity: 1,
//            child: currentPage ?? Container(),
//          ),
          // Center(
          //   child: Text(_currentIndex.toString()),
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
//    _swiperController.dispose();
    _videoListController.dispose();
    super.dispose();
  }
}