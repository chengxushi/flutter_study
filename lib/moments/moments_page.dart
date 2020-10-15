import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/moments/detail_model.dart';
import 'package:flutter_study/moments/photo_play.dart';
import 'package:flutter_study/moments/video_play.dart';
import 'package:flutter_study/router/flutter_study_routes.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class MomentsPage extends StatefulWidget {
  @override
  MomentsPageState createState() => MomentsPageState();
}

class MomentsPageState extends State<MomentsPage> {
  List<DetailModel> modelList = [];
  DetailModel model;

  @override
  void initState() {
    super.initState();
    model = DetailModel(
      avatar: 'https://profile.csdnimg.cn/A/2/6/3_littlefish_zyy',
      comment: '评论评论',
      content: '内容内容',
      name: '名称',
      createTime: '2020-20-20',
      pusher: 'pusher',
      shareNum: 100,
      avs: [
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-3.png', ),
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-4.png', ),
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-5.png', ),
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-6.png', ),
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-7.png', ),
        Avs(path: 'https://pcdn.flutterchina.club/imgs/6-8.png', ),
      ],
    );
    modelList.addAll([
      model,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: modelList.length,
        itemBuilder: (context, index){
          return _detailItem(context, MediaQuery.of(context).size.width, modelList[index]);
        },
      ),
    );
  }

  ///详情的item
  _detailItem(BuildContext context, double winWidth, DetailModel detail) {
    int imageSize = detail.avs.length;
    double imageWidth = (winWidth - 12 - 42 - 12) /
        ((imageSize == 3 || imageSize > 4)
            ? 3.0
            : (imageSize == 2 || imageSize == 4) ? 2.0 : 1.5);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 9,
          width: double.infinity,
          color: Color(0xFFF2F2F2),
        ),
        Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    image: DecorationImage(
                        image: NetworkImage(detail.avatar), fit: BoxFit.fill)),
                margin: EdgeInsets.only(right: 10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            detail.pusher,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            height: 22,
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.share, size: 20,),
                                Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Text(
                                    detail.shareNum.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 40, 10),
                      child: Text(
                        detail.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    detail.avs[0].type != 1
                        ? _imageGridView(detail.avs, imageWidth)
                        : GestureDetector(
                      onTap: () => ViewPlay(),
                      child: Container(
                        height: 300,
                        width: 200,
                        child: Text(''),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            detail.createTime,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                detail.name,
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  ///图片列表
  _imageGridView(List<Avs> avList, double imageWidth) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 8.0),
      itemCount: avList.length,
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: imageWidth,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 1),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.all(2),
        child: GestureDetector(
          onTap: () {
            List<String> imageList = List();
            for (int i = 0; i < avList.length; i++) {
              imageList.add(avList[i].path);
            }
            Navigator.pushNamed(context, Routes.photoPlay, arguments: <String, dynamic>{
              'pics': imageList,
              'index': index,
            });
            // Navigator.push(
            //   context,
            //   PageRouteBuilder(
            //     opaque: false,
            //     pageBuilder: (context, animation, secondaryAnimation) =>
            //         PhotoPlay(
            //       pics: imageList,
            //       index: index,
            //     ),
            //   ),
            // );
          },
          child: Hero(
            tag: avList[index].path,
            child: ExtendedImage.network(
              avList[index].path,
              fit: BoxFit.cover,
              width: imageWidth,
              height: imageWidth,
            ),
          ),
        ),
      ),
    );
  }
}