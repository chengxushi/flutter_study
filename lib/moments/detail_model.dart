/// @description 
/// @Created by huang
/// @Date   2020/9/23
/// @email  a12162266@163.com

class DetailModel {
  String _avatar;
  List<Avs> _avs;
  String _comment;
  String _content;
  String _createTime;
  int _id;
  String _name;
  String _pusher;
  int _shareNum;
  int _status;

  DetailModel(
      {String avatar,
        List<Avs> avs,
        String comment,
        String content,
        String createTime,
        int id,
        String name,
        String pusher,
        int shareNum,
        int status}) {
    this._avatar = avatar;
    this._avs = avs;
    this._comment = comment;
    this._content = content;
    this._createTime = createTime;
    this._id = id;
    this._name = name;
    this._pusher = pusher;
    this._shareNum = shareNum;
    this._status = status;
  }
  
  String get avatar => _avatar;
  set avatar(String avatar) => _avatar = avatar;
  List<Avs> get avs => _avs;
  set avs(List<Avs> avs) => _avs = avs;
  String get comment => _comment;
  set comment(String comment) => _comment = comment;
  String get content => _content;
  set content(String content) => _content = content;
  String get createTime => _createTime;
  set createTime(String createTime) => _createTime = createTime;
  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get pusher => _pusher;
  set pusher(String pusher) => _pusher = pusher;
  int get shareNum => _shareNum;
  set shareNum(int shareNum) => _shareNum = shareNum;
  int get status => _status;
  set status(int status) => _status = status;

  DetailModel.fromJson(Map<String, dynamic> json) {
    _avatar = json['avatar'];
    if (json['avs'] != null) {
      _avs = new List<Avs>();
      json['avs'].forEach((v) {
        _avs.add(new Avs.fromJson(v));
      });
    }
    _comment = json['comment'];
    _content = json['content'];
    _createTime = json['createTime'];
    _id = json['id'];
    _name = json['name'];
    _pusher = json['pusher'];
    _shareNum = json['shareNum'];
    _status = json['status'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this._avatar;
    if (this._avs != null) {
      data['avs'] = this._avs.map((v) => v.toJson()).toList();
    }
    data['comment'] = this._comment;
    data['content'] = this._content;
    data['createTime'] = this._createTime;
    data['id'] = this._id;
    data['name'] = this._name;
    data['pusher'] = this._pusher;
    data['shareNum'] = this._shareNum;
    data['status'] = this._status;
    return data;
  }
}

class Avs {
  String _createTime;
  int _fansPopId;
  int _id;
  int _orderNum;
  String _path;
  int _type;
  
  Avs(
      {String createTime,
        int fansPopId,
        int id,
        int orderNum,
        String path,
        int type}) {
    this._createTime = createTime;
    this._fansPopId = fansPopId;
    this._id = id;
    this._orderNum = orderNum;
    this._path = path;
    this._type = type;
  }
  
  String get createTime => _createTime;
  set createTime(String createTime) => _createTime = createTime;
  int get fansPopId => _fansPopId;
  set fansPopId(int fansPopId) => _fansPopId = fansPopId;
  int get id => _id;
  set id(int id) => _id = id;
  int get orderNum => _orderNum;
  set orderNum(int orderNum) => _orderNum = orderNum;
  String get path => _path;
  set path(String path) => _path = path;
  int get type => _type;
  set type(int type) => _type = type;
  
  Avs.fromJson(Map<String, dynamic> json) {
    _createTime = json['createTime'];
    _fansPopId = json['fansPopId'];
    _id = json['id'];
    _orderNum = json['orderNum'];
    _path = json['path'];
    _type = json['type'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createTime'] = this._createTime;
    data['fansPopId'] = this._fansPopId;
    data['id'] = this._id;
    data['orderNum'] = this._orderNum;
    data['path'] = this._path;
    data['type'] = this._type;
    return data;
  }
}