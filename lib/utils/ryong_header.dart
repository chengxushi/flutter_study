import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class RYongHeader extends Header {
  /// Key
  final Key key;

  final LinkHeaderNotifier linkNotifier = LinkHeaderNotifier();

  RYongHeader({
    this.key,
    bool enableHapticFeedback = false,
  }) : super(
          extent: 80.0,
          triggerDistance: 80.0,
          float: false,
          enableHapticFeedback: enableHapticFeedback,
          enableInfiniteRefresh: false,
          completeDuration: const Duration(seconds: 1),
        );

  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    // 不能为水平方向以及反向
    assert(axisDirection == AxisDirection.down,
        'Widget can only be vertical and cannot be reversed');
    linkNotifier.contentBuilder(
        context,
        refreshState,
        pulledExtent,
        refreshTriggerPullDistance,
        refreshIndicatorExtent,
        axisDirection,
        float,
        completeDuration,
        enableInfiniteRefresh,
        success,
        noMore);
    return RYongHeaderWidget(
      key: key,
      linkNotifier: linkNotifier,
    );
  }
}

class RYongHeaderWidget extends StatefulWidget {
  final LinkHeaderNotifier linkNotifier;

  const RYongHeaderWidget({
    Key key,
    this.linkNotifier,
  }) : super(key: key);

  @override
  _RYongHeaderWidgetState createState() => _RYongHeaderWidgetState();
}

class _RYongHeaderWidgetState extends State<RYongHeaderWidget> {
  RefreshMode get _refreshState => widget.linkNotifier.refreshState;

  double get _pulledExtent => widget.linkNotifier.pulledExtent * 0.5;

  double get _indicatorExtent =>
      widget.linkNotifier.refreshIndicatorExtent * 0.8;

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
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 30,
      child: Image.asset(
        'assets/splas_2.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
