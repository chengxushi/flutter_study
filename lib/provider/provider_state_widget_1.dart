import 'package:flutter/material.dart';
import 'package:flutter_study/provider/test_model.dart';
import 'package:provider/provider.dart';

/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class ProviderState1Widget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    debugPrint('home build');
    return Scaffold(
      appBar: AppBar(title: Text('状态管理'),),
      body: ChangeNotifierProvider(
        create: (context){
          return TestModel(modelValue: 1, modelValue2: 1);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: <Widget>[
              ChildWidget1(),
              Padding(padding: const EdgeInsets.only(top: 30)),
              ChildWidget2(),
              Padding(padding: const EdgeInsets.only(top: 30)),
              ChildWidget3(),
            ],
          ),
        ),
      ),
    );
  }
  
}

class ChildWidget1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidget1 build');
    return Container(
      color: Colors.amberAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Child1'),
          Builder(
            builder: (context){
              return Text('model data: ${context.select((TestModel value) => value.modelValue)}');
            },
          ),
          RaisedButton(
            onPressed: () => context.read<TestModel>().add(),
            child: Text('add'),
          )
        ],
      ),
    );
  }
  
}
class ChildWidget2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidget2 build');
    return Selector<TestModel, int>(
      selector: (context, value) => value.modelValue2,
      builder: (BuildContext context, value, Widget child){
        return Container(
          color: Colors.amberAccent,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Child2'),
              Text('model data: $value'),
              RaisedButton(
                onPressed: () => context.read<TestModel>().add2(),
                child: Text('add'),
              )
            ],
          ),
        );
      },
    );
  }
  
}
class ChildWidget3 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    debugPrint('ChildWidget3 build');
    return Container(
      child: RaisedButton(onPressed: (){
          context.read<TestModel>().add();
        },
        child: Icon(Icons.add),),
    );
  }
  
}