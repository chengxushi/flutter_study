
import 'package:flutter_study/widget/count.dart';
import 'package:flutter_test/flutter_test.dart';

/// @description 
/// @Created by huang
/// @Date   2020/9/17
/// @email  a12162266@163.com

void main(){
  group('数字变化', (){
    test('数字应该是增加的', (){
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });
  
    test('数字应该是减少的', (){
      final counter = Counter();
      counter.decrement();
      expect(counter.value, 0);
    });
  });
}
