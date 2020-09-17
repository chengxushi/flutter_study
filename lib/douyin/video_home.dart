import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_study/utils/ryong_footer.dart';
import 'package:flutter_study/utils/ryong_header.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'douyin_page.dart';
import 'video.dart';

/// @description
/// @Created by huang
/// @Date   2020/7/1
/// @email  a12162266@163.com
class VideoHome extends StatefulWidget {
  @override
  VideoHomeState createState() => new VideoHomeState();
}

class VideoHomeState extends State<VideoHome> {
  ScrollController _controller = ScrollController();
  List<UserVideo> videoDataList = [];
  @override
  void initState() {
    super.initState();
    videoDataList = UserVideo.fetchVideo();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EasyRefresh(
          header: RYongHeader(),
          footer: RYongFooter(),
          onRefresh: () async{
            videoDataList = [];
            setState(() {
              videoDataList = UserVideo.fetchVideo();
            });
            Fluttertoast.showToast(msg: '刷新成功');
          },
          onLoad: ()async{
            if(videoDataList.length <= 10){
              setState(() {
                videoDataList.add(UserVideo(image: 'assets/splas_2.png', url: mV2, desc: '5555555555555555'));
                videoDataList.add(UserVideo(image: 'assets/pic_2.jpg', url: mockVideo, desc: '6666666666666666'));
                videoDataList.add(UserVideo(image: 'assets/pic_3.jpg', url: mV4, desc: '7777777777777777777'));
                videoDataList.add(UserVideo(image: 'assets/pic_4.jpg', url: mV5, desc: '88888888888888888'));
              });
            }else {
              Fluttertoast.showToast(msg: '无更多数据');
            }
          },
          child: GridView.builder(
            itemCount: videoDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //一行的个数
                crossAxisSpacing: 2.0,//纵轴间距
                mainAxisSpacing: 2.0, //主轴间距
                childAspectRatio: 9/16 //长宽比
            ),
            controller: _controller,
            itemBuilder: (context, index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DouYinPage(index, videoDataList)));
                },
                child: Container(
                  color: Colors.amberAccent,
                  child: Image.asset(videoDataList[index].image, fit: BoxFit.contain,),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}