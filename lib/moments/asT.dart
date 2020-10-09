/// @description 
/// @Created by huang
/// @Date   2020/9/30
/// @email  a12162266@163.com

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}