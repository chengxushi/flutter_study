import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/widgets.dart';

/// @description EventBus的工具类
/// @Created by huang
/// @Date   2020/4/15
/// @email  a12162266@163.com

/// EventBus的工具类
class EventBusUtils {
  // 单例模式
  static EventBus _eventBus;
  
  static EventBus shared() {
    if (_eventBus == null) {
      _eventBus = EventBus(); // 创建事件总线
    }
    return _eventBus;
  }
  
  /// 订阅者
  static Map<Type, List<StreamSubscription>> subscriptions = {};
  
  /// 添加监听事件
  /// [T] 事件泛型 必须要传
  /// [onData] 接受到事件
  /// [autoManaged] 自动管理实例，off 取消
  static StreamSubscription on<T extends Object>(void onData(T event),
      {Function onError,
        void onDone(),
        bool cancelOnError,
        bool autoManaged = true}) {
    StreamSubscription subscription = shared()?.on<T>()?.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError);
    if (autoManaged == true) {
      if (subscriptions == null) subscriptions = {};
      List<StreamSubscription> subs = subscriptions[T.runtimeType] ?? [];
      subs.add(subscription);
      subscriptions[T.runtimeType] = subs;
    }
    return subscription;
  }
  
  /// 移除监听者
  /// [T] 事件泛型 必须要传
  /// [subscription] 指定
  static void off<T extends Object>({StreamSubscription subscription}) {
    if (subscriptions == null) subscriptions = {};
    if (subscription != null) {
      // 移除传入的
      List<StreamSubscription> subs = subscriptions[T.runtimeType] ?? [];
      subs.remove(subscription);
      subscriptions[T.runtimeType] = subs;
    } else {
      // 移除全部
      subscriptions[T.runtimeType] = null;
    }
  }
  
  /// 发送事件
  static void fire(event) {
    shared()?.fire(event);
  }
}

/// EventBus的工具类
/// 有状态组件
mixin EventBusMixin<T extends StatefulWidget> on State<T> {
  /// 需要定义成全局的,共用一个是实例
  EventBus mEventBus = EventBusUtils.shared();
  
  /// 订阅者
  List<StreamSubscription> mEventBusSubscriptions = [];
  
  /// 统一在这里添加监听者
  @protected
  void mAddEventBusListeners();
  
  /// 添加监听事件
  void mAddEventBusListener<T>(void onData(T event),
      {Function onError, void onDone(), bool cancelOnError}) {
    mEventBusSubscriptions?.add(mEventBus?.on<T>()?.listen(onData,
        onError: onError, onDone: onDone, cancelOnError: cancelOnError));
  }
  
  /// 发送事件
  void mEventBusFire(event) {
    mEventBus?.fire(event);
  }
  
  @override
  @mustCallSuper
  void dispose() {
    super.dispose();
    debugPrint('dispose:EventBusMixin');
    if (mEventBusSubscriptions != null)
      for (StreamSubscription subscription in mEventBusSubscriptions) {
        subscription.cancel();
      }
  }
  
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    debugPrint('initState:EventBusMixin');
    mAddEventBusListeners();
  }
}