import 'package:flutter/material.dart';
import 'package:flutter_study/provider/custom_model.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class InheritedWidgetReadOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RootContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Widget2(),
            Widget3(),
          ],
        ),
      ),
    );
  }
}

class ChildReadOnly extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReadOnlyRoot root = ReadOnlyRoot.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('InheritedWidget本身不具有写数据的功能，需要结合State来获取数据修改的能力'),
          Text('count: ${root.count}'),
        ],
      ),
    );
  }
  
}

class ReadOnlyRoot extends InheritedWidget {
  static ReadOnlyRoot of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ReadOnlyRoot>();
  final int count;

  ReadOnlyRoot({
    Key key,
    @required this.count,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(ReadOnlyRoot oldWidget) => count != oldWidget.count;
  
}

class RootContainer extends StatefulWidget{
  final Widget child;

  RootContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  _RootContainerState createState() => _RootContainerState();

  //返回指定类型的InheritedWidget，同时也会将Context对应的Widget添加到订阅者列表中
  static _RootContainerState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<Root>().state;
  //只会返回指定类型的InheritedWidget，而不会将监听加入订阅者列表中, 不会rebuild
  static _RootContainerState ofNoBuild(BuildContext context) => context.findAncestorWidgetOfExactType<Root>().state;
}
class _RootContainerState extends State<RootContainer> {
  int count = 0;
  void incrementCounter() => setState(() => count++);
  CustomModel model = CustomModel();
  
  @override
  Widget build(BuildContext context) {
    print('build Root');
    return Root(state: this, child: widget.child);
  }
}

// 同时支持读取和写入
class Root extends InheritedWidget {
  final _RootContainerState state;

  Root({
    Key key,
    @required this.state,
    @required Widget child,
  }) : super(key: key, child: child);

  // 判断是否需要更新
  @override
  bool updateShouldNotify(Root oldWidget) => true;
}

class Widget1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('build Widget1');
    return Text('InheritedWidget本身不具有写数据的功能，需要结合State来获取数据修改的能力');
  }
}

class Widget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('build Widget2');
    return Text(
      'show ${RootContainer.of(context).count}',
      style: TextStyle(fontSize: 20),
    );
  }
}

class Widget3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPrint('build Widget3');
    return RaisedButton(
      onPressed: () {
        RootContainer.ofNoBuild(context).incrementCounter();
      },
      child: Text('Add'),
    );
  }
}

