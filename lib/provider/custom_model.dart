/// @description
/// @Created by huang
/// @Date   2020/9/16
/// @email  a12162266@163.com

class CustomModel{
  final int value;
  
  const CustomModel({this.value = 0});
  
  @override
  bool operator == (Object other){
    //检查两个引用是否指向同一个对象
    if(identical(this, other)) return true;
    if(other.runtimeType != runtimeType) return false;
    final CustomModel otherModel = other;
    return otherModel.value == value;
  }
  @override
  int get hashCode => value.hashCode;
}