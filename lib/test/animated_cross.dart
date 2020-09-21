

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// @description
/// @Created by huang
/// @Date   2020/9/18
/// @email  a12162266@163.com
class CurveAnimatedCrossFade extends StatefulWidget {
  @override
  _CurveAnimatedCrossFadeState createState() => _CurveAnimatedCrossFadeState();
}

class _CurveAnimatedCrossFadeState extends State<CurveAnimatedCrossFade> {
  var _crossFadeState = CrossFadeState.showFirst;
  
  bool get isFirst=> _crossFadeState == CrossFadeState.showFirst;

  final Decoration startDecoration = BoxDecoration(
      color: Colors.blue,
      image: DecorationImage(
          image: AssetImage('assets/images/icon_head.png'), fit: BoxFit.cover),
      borderRadius: BorderRadius.all(Radius.circular(20)));
  final Decoration endDecoration = BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/icon_head.png'), fit: BoxFit.cover),
      color: Colors.orange,
      borderRadius: BorderRadius.all(Radius.circular(50)));

  final Alignment startAlignment = Alignment(0, 0);
  final Alignment endAlignment = Alignment.topLeft + Alignment(0.2, 0.2);

  final startHeight = 100.0;
  final endHeight = 50.0;

  Decoration _decoration;
  double _height;
  Alignment _alignment;
  
  ValueNotifier<CrossFadeState> _notifier = ValueNotifier<CrossFadeState>(CrossFadeState.showFirst);

  @override
  void initState() {
    _decoration = startDecoration;
    _height = startHeight;
    _alignment=startAlignment;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('${_notifier.value}');
          if(_notifier.value == CrossFadeState.showFirst){
            _notifier.value = CrossFadeState.showSecond;
          } else {
            _notifier.value = CrossFadeState.showFirst;
          }
        },
      ),
      body: Column(
        children: [
          Wrap(
            children: <Widget>[
              ValueListenableBuilder(valueListenable: _notifier, builder: (context,value, child){
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      if(_crossFadeState == CrossFadeState.showFirst){
                        _crossFadeState = CrossFadeState.showSecond;
                      } else {
                        _crossFadeState = CrossFadeState.showFirst;
                      }
                    });
                  },
                  child: Container(
                    child: AnimatedCrossFade(
                      firstCurve: Curves.easeInCirc,
                      secondCurve: Curves.easeInToLinear,
                      sizeCurve: Curves.bounceOut,
                      firstChild: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 80,
                        color: Colors.orange  ,
                        child: FlutterLogo(textColor: Colors.blue,size: 50,),
                      ),
                      secondChild: Container(
                        width: 200,
                        height: 150,
                        alignment: Alignment.center,
                        color: Colors.blue,
                        child: FlutterLogo(
                          textColor: Colors.white,
//                colors: Colors.orange,
                          size: 100,style: FlutterLogoStyle.stacked,),
                      ),
                      duration: Duration(milliseconds: 1000),
                      crossFadeState: _notifier.value,
                    ),
                  ),
                );
              },),
              _buildSwitch(),
            ],
          ),
          Text('两个组件切换时呈现动画效果', style: TextStyle(fontSize: 20,),),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            alignment: _alignment,
            color: Colors.grey.withAlpha(22),
            width: 200,
            height: 120,
            child: UnconstrainedBox(
              child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
                decoration: _decoration,
                onEnd: () => print('End'),
                height: _height,
                width: _height,
              ),
            ),
          ),
          Switch(value: _height == endHeight, onChanged: (v){
            setState(() {
              _height = v ? endHeight : startHeight;
              _decoration = v ? endDecoration : startDecoration;
              _alignment = v ? endAlignment : startAlignment;
            });
          })
        ],
      ),
    );
  }
  
  Widget _buildSwitch() => Switch(value: isFirst, onChanged: (v){
    setState(() {
      _crossFadeState= v?CrossFadeState.showFirst:CrossFadeState.showSecond;
    });
  });
}

