import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_fijl_slider.dart';

FijkPanelWidgetBuilder customFijkPanelBuilder({
  Key key,
  final bool fill = false,
  final int duration = 4000,
  final bool doubleTap = true,
  final VoidCallback onBack,
}) {
  return (FijkPlayer player, FijkData data, BuildContext context, Size viewSize,
      Rect texturePos) {
    return CustomFijkPanel(
      key: key,
      player: player,
      data: data,
      onBack: onBack,
      viewSize: viewSize,
      texPos: texturePos,
      fill: fill,
      doubleTap: doubleTap,
      hideDuration: duration,
    );
  };
}

class CustomFijkPanel extends StatefulWidget {
  final FijkPlayer player; //播放器 FijkPlayer 对象
  final FijkData data; //全屏模式和非全屏模式切换保存的数据
  final VoidCallback onBack;
  final Size viewSize; //对应 FijkView 的实际显示大小
  final Rect texPos; //FijkView 中实际视频显示的相对位置, 这个相对位置可能超出 FijkView 的实际大小
  final bool fill; //是否全屏
  final bool doubleTap;
  final int hideDuration;

  const CustomFijkPanel(
      {Key key,
      @required this.player,
      this.data,
      this.fill,
      this.onBack,
      this.viewSize,
      this.hideDuration,
      this.doubleTap,
      this.texPos})
      : assert(player != null),
        assert(
            hideDuration != null && hideDuration > 0 && hideDuration < 10000),
        super(key: key);

  @override
  _CustomFijkPanelState createState() => _CustomFijkPanelState();
}

String duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negtive";

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

class _CustomFijkPanelState extends State<CustomFijkPanel> {
  FijkPlayer get player => widget.player;

  Timer _hideTimer;

//
//  ///添加定时上传的计时器
//  ///每30秒上传一次进度->30秒倒计时
//  Timer _timer;
//  int _countDown = 30;

  ///是否显示自定义UI
  bool _hideStuff = false;

  Timer _statelessTimer;
  bool _prepared = false;
  bool _playing = false;
  bool _dragLeft;
  double _volume;
  double _brightness;

  double _seekPos = -1.0;
  Duration _duration = Duration();
  Duration _currentPos = Duration();
  Duration _bufferPos = Duration();

  StreamSubscription _currentPosSubs;
  StreamSubscription _bufferPosSubs;

  StreamController<double> _valController;

  void _playerValueChanged() {
    FijkValue value = player.value;

    if (value.duration != _duration) {
      if (_hideStuff == false) {
        setState(() {
          _duration = value.duration;
        });
      } else {
        _duration = value.duration;
      }
    }

    bool playing = (value.state == FijkState.started);
    bool prepared = value.prepared;
    if (playing != _playing ||
        prepared != _prepared ||
        value.state == FijkState.asyncPreparing) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
      });
    }

    switch (value.state) {
      case FijkState.idle:
        // TODO: Handle this case.
        break;
      case FijkState.initialized:
        // TODO: Handle this case.
        break;
      case FijkState.asyncPreparing:
        // TODO: Handle this case.
        break;
      case FijkState.prepared:
        // TODO: Handle this case.
        break;
      case FijkState.started:
        // TODO: Handle this case.
//        ///确保有加载进度了再开始倒计时
//        if (_timer == null && _duration.inMilliseconds > 0) {
//          _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//            if (_countDown < 1) {
//              Provider.of<PlayVideoProvider>(context, listen: false)
//                  .courseProgress();
//              _countDown = 30;
//            } else {
//              _countDown = _countDown - 1;
//              print('_countDown->>>$_countDown');
//            }
//          });
//        }
        break;
      case FijkState.paused:
        // TODO: Handle this case.
//        bool _isClickStart =
//            Provider.of<PlayVideoProvider>(context, listen: false).isClickStart;
//        if (_isClickStart) {
//          Provider.of<PlayVideoProvider>(context, listen: false)
//              .courseProgress();
//          _countDown = 30;
//          _timer?.cancel();
//          _timer = null;
//        }
        break;
      case FijkState.completed:
        // TODO: Handle this case.
//        Provider.of<PlayVideoProvider>(context, listen: false)
//            .courseProgress(time: 0);
//        _countDown = 30;
//        _timer?.cancel();
//        _timer = null;
        break;
      case FijkState.stopped:
        // TODO: Handle this case.
//        Provider.of<PlayVideoProvider>(context, listen: false).courseProgress();
//        _countDown = 30;
//        _timer?.cancel();
//        _timer = null;
        break;
      case FijkState.error:
        // TODO: Handle this case.
        break;
      case FijkState.end:
        // TODO: Handle this case.
        break;
    }
  }

  static const CustomFijkSliderColors sliderColors = CustomFijkSliderColors(
    cursorColor: Colors.white,
    playedColor: Colors.white,
    baselineColor: Colors.grey,
    bufferedColor: Colors.white70,
  );

  @override
  void initState() {
    super.initState();
    _valController = StreamController.broadcast();
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _duration = player.value.duration;
    // 当前播放位置
    _currentPos = player.currentPos;
    _bufferPos = player.bufferPos;

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      if (_hideStuff == false) {
        setState(() {
          _currentPos = v;
        });
      } else {
        _currentPos = v;
      }
    });

    _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
      if (_hideStuff == false) {
        setState(() {
          _bufferPos = v;
        });
      } else {
        _bufferPos = v;
      }
    });

    player.addListener(_playerValueChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _valController?.close();
    _hideTimer?.cancel();
//    _timer?.cancel();
    _statelessTimer?.cancel();
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
    player.removeListener(_playerValueChanged);
  }

  double dura2double(Duration d) {
    return d != null ? d.inMilliseconds.toDouble() : 0.0;
  }

  void _restartHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(Duration(milliseconds: widget.hideDuration), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void onTapFun() {
    print('----------------onTapFun--------------');
    if (_hideStuff == true) {
      _restartHideTimer();
    }
    setState(() {
      _hideStuff = !_hideStuff;
    });
  }

  void playOrPause() {
    print('----------------playOrPause--------------');
    if (player.isPlayable() || player.state == FijkState.asyncPreparing) {
      if (player.state == FijkState.started) {
        player.pause();
        setState(() {
          _hideStuff = false;
        });
      } else {
//        int _seek = Provider.of<PlayVideoProvider>(context, listen: false)
//            .courseInfo
//            .videolastPlay;
//        player.seekTo(_seek * 1000);
        player.start();
        _restartHideTimer();
      }
    } else {
      FijkLog.w("Invalid state ${player.state} ,can't perform play or pause");
    }
  }

  void onDoubleTapFun() {
    print('----------------onDoubleTapFun--------------');
    playOrPause();
  }

  void onVerticalDragStartFun(DragStartDetails d) {
    print('----------------onVerticalDragStartFun--------------');
    if (d.localPosition.dx > panelWidth() / 2) {
      // right, volume
      _dragLeft = false;
      FijkVolume.getVol().then((v) {
        if (widget.data != null &&
            !widget.data.contains('__fijkview_panel_init_volume')) {
          widget.data.setValue('__fijkview_panel_init_volume', v);
        }
        setState(() {
          _volume = v;
          _valController.add(v);
        });
      });
    } else {
      // left, brightness
      _dragLeft = true;
      FijkPlugin.screenBrightness().then((v) {
        if (widget.data != null &&
            !widget.data.contains('__fijkview_panel_init_brightness')) {
          widget.data.setValue('__fijkview_panel_init_brightness', v);
        }
        setState(() {
          _brightness = v;
          _valController.add(v);
        });
      });
    }
    _statelessTimer?.cancel();
    _statelessTimer = Timer(const Duration(milliseconds: 2000), () {
      setState(() {});
    });
  }

  double panelWidth() {
    if (player.value.fullScreen || (true == widget.fill)) {
      return widget.viewSize.width;
    } else {
      return min(widget.viewSize.width, widget.texPos.right) -
          max(0.0, widget.texPos.left);
    }
  }

  void onVerticalDragUpdateFun(DragUpdateDetails d) {
    print('----------------onVerticalDragUpdateFun--------------');
    double delta = d.primaryDelta / panelHeight();
    delta = -delta.clamp(-1.0, 1.0);
    if (_dragLeft != null && _dragLeft == false) {
      if (_volume != null) {
        _volume += delta;
        _volume = _volume.clamp(0.0, 1.0);
        FijkVolume.setVol(_volume);
        setState(() {
          _valController.add(_volume);
        });
      }
    } else if (_dragLeft != null && _dragLeft == true) {
      if (_brightness != null) {
        _brightness += delta;
        _brightness = _brightness.clamp(0.0, 1.0);
        FijkPlugin.setScreenBrightness(_brightness);
        setState(() {
          _valController.add(_brightness);
        });
      }
    }
  }

  void onVerticalDragEndFun(DragEndDetails e) {
    print('----------------onVerticalDragEndFun--------------');
    _volume = null;
    _brightness = null;
  }

  //面板中的播放暂停按钮
  Widget buildPlayButton(BuildContext context, double height) {
    Icon icon = (player.state == FijkState.started)
        ? Icon(Icons.pause)
        : Icon(Icons.play_arrow);
    return IconButton(
      padding: EdgeInsets.all(0),
      iconSize: 50,
      color: Color(0xFFFFFFFF),
      icon: icon,
      onPressed: playOrPause,
    );
  }

  Rect panelRect() {
    Rect rect = player.value.fullScreen || (true == widget.fill)
        ? Rect.fromLTWH(0, 0, widget.viewSize.width, widget.viewSize.height)
        : Rect.fromLTRB(
            max(0.0, widget.texPos.left),
            max(0.0, widget.texPos.top),
            min(widget.viewSize.width, widget.texPos.right),
//        max(widget.viewSize.height + 6, widget.texPos.bottom),
            max(widget.viewSize.height, widget.texPos.bottom), //设置视频播放的进度条的位置, 这个参数是整体的高度,增大的话可以将进度条的那一栏UI整体向下移 ,
    );
    return rect;
  }

  Widget buildStateless() {
    if (_volume != null || _brightness != null) {
      Widget toast = _volume == null
          ? defaultFijkBrightnessToast(_brightness, _valController.stream)
          : defaultFijkVolumeToast(_volume, _valController.stream);
      return IgnorePointer(
        child: AnimatedOpacity(
          opacity: 1,
          duration: Duration(milliseconds: 500),
          child: toast,
        ),
      );
    } else if (player.state == FijkState.asyncPreparing) {
      return Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white)),
        ),
      );
    } else if (player.state == FijkState.error) {
      return Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.error,
          size: 30,
          color: Color(0x99FFFFFF),
        ),
      );
    } else {
      return Container();
    }
  }

  //全屏按钮
  Widget buildFullScreenButton(BuildContext context, double height) {
    Icon icon = player.value.fullScreen
        ? Icon(Icons.fullscreen_exit)
        : Icon(Icons.fullscreen);
    return IconButton(
      padding: EdgeInsets.all(0),
      iconSize: height * 0.6,
      color: Color(0xFFFFFFFF),
      icon: icon,
      onPressed: () {
        player.value.fullScreen
            ? player.exitFullScreen()
            : player.enterFullScreen();
      },
    );
  }

  Widget buildTimeText(BuildContext context, double height) {
    String text =
        "${duration2String(_currentPos)}" + "/${duration2String(_duration)}";
    return Text(text, style: TextStyle(fontSize: 12, color: Color(0xFFFFFFFF)));
  }

  ///当前时间
  Widget buildTimeText01(BuildContext context, double height) {
    String text = "${duration2String(_currentPos)}";
    return Text(text,
        style: TextStyle(
            fontSize: 14,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold));
  }

  ///总时长
  Widget buildTimeText02(BuildContext context, double height) {
    String text = "${duration2String(_duration)}";
    return Text(text,
        style: TextStyle(
            fontSize: 14,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold));
  }

  Widget buildSlider(BuildContext context) {
    double duration = dura2double(_duration);

    double currentValue = _seekPos > 0 ? _seekPos : dura2double(_currentPos);
    currentValue = currentValue.clamp(0.0, duration);

    double bufferPos = dura2double(_bufferPos);
    bufferPos = bufferPos.clamp(0.0, duration);

    return Padding(
      padding: EdgeInsets.only(
          left: 10, right: 12),
      child: CustomFijkSlider(
        colors: sliderColors,
        value: currentValue,
        cacheValue: bufferPos,
        min: 0.0,
        max: duration,
        onChanged: (v) {
          _restartHideTimer();
          setState(() {
            _seekPos = v;
          });
        },
        onChangeEnd: (v) {
          setState(() {
            player.seekTo(v.toInt());
            _currentPos = Duration(milliseconds: _seekPos.toInt());
            _seekPos = -1.0;
            player.start();
//            Provider.of<PlayVideoProvider>(context, listen: false)
//                .courseProgress();
          });
        },
      ),
    );
  }

  Widget buildBottom(BuildContext context, double height) {
    if (_duration != null && _duration.inMilliseconds > 0) {
      return Row(
        children: <Widget>[
//          buildPlayButton(context, height),
//          buildTimeText(context, height),
          buildTimeText01(context, height),
          Expanded(child: buildSlider(context)),
          buildTimeText02(context, height),
          buildFullScreenButton(context, height),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
//          buildPlayButton(context, height),
          Expanded(child: Container()),
          buildFullScreenButton(context, height),
        ],
      );
    }
  }

  Widget buildPanel(BuildContext context) {
    double height = panelHeight();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        //返回按钮
        Container(
          height: height > 200 ? 80 : height / 5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
            colors: [Color(0x88000000), Color(0x00000000)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          ),
          padding: EdgeInsets.only(left: 20),
          child: buildBack(context),
        ),
        //播放暂停
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: 100,
            height: 100,
            child: buildPlayButton(context, height > 80 ? 40 : height / 2),
          ),
        ),
        Container(
          height: height > 80 ? 80 : height / 2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x88000000), Color(0x00000000)],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: height > 80 ? 45 : height / 2,
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 5),
            child: buildBottom(context, height > 80 ? 40 : height / 2),
          ),
        )
      ],
    );
  }

  double panelHeight() {
    if (player.value.fullScreen || (true == widget.fill)) {
      return widget.viewSize.height;
    } else {
      return min(widget.viewSize.height, widget.texPos.bottom) -
          max(0.0, widget.texPos.top);
    }
  }

  Widget buildBack(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(left: 5),
      icon: Icon(
        Icons.arrow_back_ios,
        color: Color(0xDDFFFFFF),
      ),
      onPressed: widget.onBack,
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: onTapFun,
      onDoubleTap: widget.doubleTap ? onDoubleTapFun : null,
      onVerticalDragUpdate: onVerticalDragUpdateFun,
      onVerticalDragStart: onVerticalDragStartFun,
      onVerticalDragEnd: onVerticalDragEndFun,
      onHorizontalDragUpdate: (d) {},
      child: AbsorbPointer(
        absorbing: _hideStuff,
        child: AnimatedOpacity(
          opacity: _hideStuff ? 0 : 1.0,
          duration: Duration(milliseconds: 300),
          child: buildPanel(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = panelRect();
    List ws = <Widget>[];
    if (_statelessTimer != null && _statelessTimer.isActive) {
      ws.add(buildStateless());
    } else if (player.state == FijkState.asyncPreparing) {
      ws.add(buildStateless());
    } else if (player.state == FijkState.error) {
      ws.add(buildStateless());
    }
    ws.add(buildGestureDetector(context));
    if (widget.onBack != null) {
      ws.add(buildBack(context));
    }
    return Positioned.fromRect(
      rect: rect,
      child: Stack(
        overflow: Overflow.visible,
        children: ws
      ),
    );
  }
}
