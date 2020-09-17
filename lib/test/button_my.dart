import 'package:flutter/material.dart';
class ButtonMy extends StatefulWidget {
  @override
  _ButtonMyState createState() => _ButtonMyState();
}

class _ButtonMyState extends State<ButtonMy> {
  var _isSelected = [true, false, false];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ToggleButtons(
          children: <Widget>[
            Icon(Icons.skip_previous, size: 20,),
            Icon(Icons.pause, size: 100,),
            Icon(Icons.skip_next),
          ],
          borderWidth: 0,
          renderBorder: false,
          borderRadius: BorderRadius.circular(10),
          isSelected: _isSelected,
          onPressed: (value){
            switch(value){
              case 0:
                print('上一首');
                break;
              case 1:
                print('暂停');
                break;
              case 2:
                print('下一首');
                break;
            }
            setState(() {
              _isSelected = _isSelected.map((e) => false).toList();
              _isSelected[value] = true;
            });
          },
          selectedColor: Colors.amberAccent, //选中的颜色
          fillColor: Colors.grey,
          
        ),
      ),
    );
  }
}