import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

/// 金色校园Footer
class RYongFooter extends Footer {
  /// Key
  final Key key;

  final LinkFooterNotifier linkNotifier = LinkFooterNotifier();

  RYongFooter({
    this.key,
    bool enableHapticFeedback = false,
  }) : super(
          extent: 80.0,
          triggerDistance: 80.0,
          float: false,
          enableHapticFeedback: enableHapticFeedback,
          enableInfiniteLoad: false,
          completeDuration: const Duration(seconds: 1),
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      LoadMode loadState,
      double pulledExtent,
      double loadTriggerPullDistance,
      double loadIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteLoad,
      bool success,
      bool noMore) {
    // 不能为水平方向以及反向
    assert(axisDirection == AxisDirection.down,
        'Widget can only be vertical and cannot be reversed');
    linkNotifier.contentBuilder(
        context,
        loadState,
        pulledExtent,
        loadTriggerPullDistance,
        loadIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteLoad,
        success,
        noMore);
    return RYongFooterFooterWidget(
      key: key,
      linkNotifier: linkNotifier,
    );
  }
}

class RYongFooterFooterWidget extends StatefulWidget {
  final LinkFooterNotifier linkNotifier;

  const RYongFooterFooterWidget({
    Key key,
    this.linkNotifier,
  }) : super(key: key);

  @override
  RYongFooterFooterWidgetState createState() {
    return RYongFooterFooterWidgetState();
  }
}

class RYongFooterFooterWidgetState extends State<RYongFooterFooterWidget> {
  LoadMode get _loadState => widget.linkNotifier.loadState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent * 0.5;

  double get _indicatorExtent => widget.linkNotifier.loadIndicatorExtent * 0.8;

  bool get _noMore => widget.linkNotifier.noMore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_noMore) return Container();

    return Stack(
      children: <Widget>[
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            width: double.infinity,
            height: _pulledExtent > _indicatorExtent
                ? _pulledExtent
                : _indicatorExtent,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    alignment: Alignment.center,
                    height: 40,
                    child: Image.asset(
                      'assets/splas_2.png',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
