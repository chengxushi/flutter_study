import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

/// @description
/// @Created by huang
/// @Date   2020/10/9
/// @email  a12162266@163.com

class FlareTest extends StatefulWidget {
  @override
  FlareTestState createState() => FlareTestState();
}

class FlareTestState extends State<FlareTest> {
  String _aniName = 'night_idle';

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
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              switch(_aniName) {
                case 'night_idle':
                  setState(() {
                    _aniName = 'switch_day';
                  });
                  break;
                case 'day_idle':
                  setState(() {
                    _aniName = 'switch_night';
                  });
                  break;
                case 'switch_night':
                  break;
                case 'switch_day':
                  break;
              }
            },
            child: Container(
              margin: EdgeInsets.only(top: 100),
              height: 100,
              child: FlareActor(
                'assets/flr/switch_daytime.flr',
                fit: BoxFit.contain,
                animation: _aniName,
                alignment: Alignment.center,
                callback: (String animationName){
                  switch(animationName) {
                    case 'night_idle':
                      break;
                    case 'day_idle':
                      break;
                    case 'switch_night':
                      setState(() {
                        _aniName = 'night_idle';
                      });
                      break;
                    case 'switch_day':
                      setState(() {
                        _aniName = 'day_idle';
                      });
                      break;
                  }
                },
              ),
            ),
          ),
          Container(
            height: 100,
            child: FlareActor(
              'assets/flr/Loading.flr',
              animation: 'Alarm',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}