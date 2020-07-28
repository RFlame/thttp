/// id : 4
/// title : "我的一条记录"
/// createTime : null
/// editTime : null
/// recordType : 0
/// parentId : null
/// status : 0
/// note : null

class Record {
  int _id;
  String _title;
  dynamic _createTime;
  dynamic _editTime;
  int _recordType;
  dynamic _parentId;
  int _status;
  dynamic _note;

  int get id => _id;
  String get title => _title;
  dynamic get createTime => _createTime;
  dynamic get editTime => _editTime;
  int get recordType => _recordType;
  dynamic get parentId => _parentId;
  int get status => _status;
  dynamic get note => _note;

  Record(this._id, this._title, this._createTime, this._editTime, this._recordType, this._parentId, this._status, this._note);

  Record.map(dynamic obj) {
    this._id = obj["id"];
    this._title = obj["title"];
    this._createTime = obj["createTime"];
    this._editTime = obj["editTime"];
    this._recordType = obj["recordType"];
    this._parentId = obj["parentId"];
    this._status = obj["status"];
    this._note = obj["note"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = _id;
    map["title"] = _title;
    map["createTime"] = _createTime;
    map["editTime"] = _editTime;
    map["recordType"] = _recordType;
    map["parentId"] = _parentId;
    map["status"] = _status;
    map["note"] = _note;
    return map;
  }

}