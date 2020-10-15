/// @description
/// @Date  2020-10-14

import 'dart:convert' show json;

T asT<T>(dynamic value) {
  if (value is T) {
    return value;
  }
  return null;
}

class UserModel{
  UserModel({
    this.name,
    this.age,
    this.isVip,
    this.avatar,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> jsonRes)=>jsonRes == null? null:UserModel(
    name : asT<String>(jsonRes['name']),
    age : asT<int>(jsonRes['age']),
    isVip : asT<bool>(jsonRes['isVip']),
    avatar : asT<String>(jsonRes['avatar']),
  );
  
  String name;
  int age;
  bool isVip;
  String avatar;
  
  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'age': age,
    'isVip': isVip,
    'avatar': avatar,
  };
  
  @override
  String  toString() {
    return json.encode(this);
  }
}

