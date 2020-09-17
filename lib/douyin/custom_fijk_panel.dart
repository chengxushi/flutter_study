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
  final int duration = 4000, //显示时间
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
  ///是否隐藏自定义UI
  bool _hideStuff = true;

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
        break;
      case FijkState.initialized:
        break;
      case FijkState.asyncPreparing:
        break;
      case FijkState.prepared:
        break;
      case FijkState.started:
        break;
      case FijkState.paused:
        break;
      case FijkState.completed:
        break;
      case FijkState.stopped:
        break;
      case FijkState.error:
        break;
      case FijkState.end:
        break;
    }
  }

  static const CustomFijkSliderColors sliderColors = CustomFijkSliderColors(
    cursorColor: Colors.white, //进度条圆块的颜色
    playedColor: Colors.white, //已播放进度的颜色
    baselineColor: Colors.transparent, //加载中的颜色
    bufferedColor: Colors.transparent, //已加载的颜色
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
        setState(() {
          _currentPos = v;
        });
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

  double panelWidth() {
    if (player.value.fullScreen || (true == widget.fill)) {
      return widget.viewSize.width;
    } else {
      return min(widget.viewSize.width, widget.texPos.right) -
          max(0.0, widget.texPos.left);
    }
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
            0.0,
            0.0,
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
          duration: Duration(milliseconds: 100),
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
  
  Widget buildBack(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Color(0xDDFFFFFF),
      ),
      onPressed: widget.onBack,
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

  //j进度条
  Widget buildSlider(BuildContext context) {
    double duration = dura2double(_duration);

    double currentValue = _seekPos > 0 ? _seekPos : dura2double(_currentPos);
    currentValue = currentValue.clamp(0.0, duration); //返回在这个范围内的数字

    double bufferPos = dura2double(_bufferPos);
    bufferPos = bufferPos.clamp(0.0, duration);

    return Padding(
      padding: EdgeInsets.only(
          left: 0, right: 0),
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
            _currentPos = Duration(milliseconds: _seekPos.toInt());
            player.seekTo(v.toInt());
            _seekPos = -1.0;
            player.start();
          });
        },
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    if (_duration != null && _duration.inMilliseconds > 0) {
      return Row(
        children: <Widget>[
          Expanded(child: buildSlider(context)),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
//          buildPlayButton(context, height),
          Expanded(child: Container()),
//          buildFullScreenButton(context, height),
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
          alignment: Alignment.topLeft,
          child: buildBack(context),
        ),
        //播放暂停
        Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.transparent,
            child: buildPlayButton(context, height > 80 ? 40 : height / 2),
          ),
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x88000000), Color(0x00000000)],
              end: Alignment.topCenter,
              begin: Alignment.bottomCenter,
            ),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            child: buildBottom(context),
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

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onTap: onTapFun,
      onDoubleTap: widget.doubleTap ? onDoubleTapFun : null,
//      onVerticalDragUpdate: onVerticalDragUpdateFun,
//      onVerticalDragStart: onVerticalDragStartFun,
//      onVerticalDragEnd: onVerticalDragEndFun,
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
//    ws.add(Positioned(
//      top: 0,
//      bottom: 0,
//      child: Container(
//        height: 40,
//        decoration: BoxDecoration(
//          gradient: LinearGradient(
//            colors: [Color(0x88000000), Color(0x00000000)],
//            end: Alignment.topCenter,
//            begin: Alignment.bottomCenter,
//          ),
//        ),
//        child: Container(
//          height: 40,
//          child: buildBottom(context),
//        ),
//      ),
//    ));
    return Positioned.fromRect(
      rect: rect,
      child: Stack(
        overflow: Overflow.visible,
        children: ws
      ),
    );
  }
}
