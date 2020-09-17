import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// @description
/// @Created by huang
/// @Date   2020/8/24
/// @email  a12162266@163.com

class CameraPage extends StatefulWidget {
  @override
  CameraPageState createState() => new CameraPageState();
}

class CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  /// 可用的相机实例
  List<CameraDescription> cameras;
  /// 当前相机实例的控制器
  CameraController cameraController;
  Future<bool> _future;

  @override
  void initState() {
    super.initState();
    _future = getCamera();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  
  Future<bool> getCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras.first, ResolutionPreset.veryHigh);
    await cameraController.initialize();
    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Center(
              child: AspectRatio(
                aspectRatio: cameraController.value.aspectRatio,
                child: CameraPreview(cameraController),
              ),
            );
          } else {
            return Container(alignment: Alignment.center, child: const CupertinoActivityIndicator(radius: 10,),);
          }
        },
      ),
    );
  }
}