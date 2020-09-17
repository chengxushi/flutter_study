//import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:flutter/material.dart';
//
///// @description
///// @Created by huang
///// @Date   2020/5/29
///// @email  a12162266@163.com
//
//class BoFangAudio extends StatefulWidget {
//  @override
//  BoFangAudioState createState() => new BoFangAudioState();
//}
//
//class BoFangAudioState extends State<BoFangAudio> {
//  final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('data'),),
//      body: Center(
//        child: OutlineButton(
//          onPressed: ()async{
//            Map<String, dynamic> map = Map();
//            map.addAll({'other': '这是啥'});
//            NotificationSettings notificationSettings = NotificationSettings(
//              seekBarEnabled: false,
//            );
//            final audio = Audio.network(
//              'https://public.bobolaile.com/upload/20200411/ea45d2dd716443cba37531072cc07542.mp3',
//              metas: Metas(
//                title: '这是标题',
//                artist: '艺术',
//                album: '公司',
//                extra: map,
//                image: MetasImage.network('https://public.bobolaile.com/upload/20200411/e0b13c2a65604dd98f616b69ad598cbf.jpg')
//              ),
//            );
//            await audioPlayer.open(
//                audio,
//                showNotification: true,
//                notificationSettings: notificationSettings,
//            );
//          },
//          child: Text('播放'),
//        ),
//      ),
//    );
//  }
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//}