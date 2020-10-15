
import 'package:flutter/material.dart';
import 'package:flutter_study/widget/tab_bar_my.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/12
/// @email  a12162266@163.com

class TabBarTest extends StatefulWidget {
  @override
  TabBarTestState createState() => TabBarTestState();
}

class TabBarTestState extends State<TabBarTest> with TickerProviderStateMixin{
  List<String> _tabList = ['发现', '我的', '视频', '活动现场', '圈子'];
  int pageIndex;
  TabController _tabController;
  TabController _tabController2;
  int _tabIndex = 0;
  double textSize = 20;
  double _fontSize = 20;

  Animation<double> animation;
  AnimationController controller;
  Animation<double> animation2;
  AnimationController controller2;
  Animation<double> animation3;
  AnimationController controller3;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);
    _tabController2 = TabController(length: _tabList.length, vsync: this);
    _tabController2.addListener(() {
      setState(() {
        _tabIndex = _tabController2.index;
      });
      print(_tabController2.index);
    });
    tabWidget();
    controller = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 1.0, end: 6.0).animate(controller);
    animation.addListener(() {
      setState(() {
      });
    });
    controller2 = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation2 = Tween<double>(begin: 20, end: 100).animate(controller2);
    animation2.addListener(() {
      setState(() {
      });
    });
    controller3 = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation3 = Tween<double>(begin: 10, end: 100).animate(controller3);
    animation3.addListener(() {
      setState(() {
      });
    });
    controller.forward();
    controller2.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Column(
        children: [
          H_TabBar(
            controller: _tabController,
            indicatorSize: H_TabBarIndicatorSize.label,
            indicator: TabIndicator(
              borderSide: const BorderSide(width: 2, color: Colors.black),
            ),
            labelStyle: TextStyle(fontSize: 28,),
            labelColor: Colors.white,
            unselectedLabelStyle: TextStyle(fontSize: 16),
            unselectedLabelColor: Colors.white.withOpacity(0.5),
            isScrollable: true,
            tabs: _tabList.map((e) => H_Tab(text: e,)).toList(),
          ),
          TabBar(
            tabs: widgetList,
            controller: _tabController2,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController2,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.reverse();
                      },
                      child: Container(
                        color: Colors.white,
                        height: 500,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          '我的',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                          textScaleFactor: animation.value,
                        ),
                      ),
                    ),
                    OutlineButton(onPressed: (){
                      controller.forward();
                    }, child: Text('点击'),),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller2.reverse();
                      },
                      child: Container(
                        color: Colors.white,
                        height: 500,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          '饕餮',
                          style: TextStyle(
                            fontSize: animation2.value,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    OutlineButton(onPressed: (){
                      controller2.forward();
                    }, child: Text('点击'),),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        color: Colors.white,
                        height: 500,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          '饕餮',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Text('饕餮', style: TextStyle(fontSize: 20, color: Colors.black,),),
                    ),
                    OutlineButton(onPressed: (){
                      controller2.forward();
                    }, child: Text('点击'),),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        color: Colors.white,
                        height: 500,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          '饕餮',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Text('饕餮', style: TextStyle(fontSize: 20, color: Colors.black,),),
                    ),
                    OutlineButton(onPressed: (){
                      controller2.forward();
                    }, child: Text('点击'),),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        color: Colors.white,
                        height: 500,
                        width: 300,
                        alignment: Alignment.center,
                        child: Text(
                          '饕餮',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Text('饕餮', style: TextStyle(fontSize: 20, color: Colors.black,),),
                    ),
                    OutlineButton(onPressed: (){
                      controller2.forward();
                    }, child: Text('点击'),),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  List<Widget> widgetList = [];
  List<Widget> tabWidget(){
    for(int i = 0; i < _tabList.length; i++){
      widgetList.add(Text(_tabList[i], style: TextStyle(fontSize: _tabIndex == i ? 20 : 16, color: Colors.white,), maxLines: 1,));
    }
    return widgetList;
  }
}