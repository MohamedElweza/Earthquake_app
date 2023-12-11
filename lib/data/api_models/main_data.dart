import 'data.dart';

class Autogenerated {
  int? httpStatus;
  String? noun;
  String? verb;
  String? errorCode;
  String? friendlyError;
  String? result;
  int? count;
  List<Data>? data;

  Autogenerated(
      {this.httpStatus,
        this.noun,
        this.verb,
        this.errorCode,
        this.friendlyError,
        this.result,
        this.count,
        this.data});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    httpStatus = json['httpStatus'];
    noun = json['noun'];
    verb = json['verb'];
    errorCode = json['errorCode'];
    friendlyError = json['friendlyError'];
    result = json['result'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['httpStatus'] = this.httpStatus;
    data['noun'] = this.noun;
    data['verb'] = this.verb;
    data['errorCode'] = this.errorCode;
    data['friendlyError'] = this.friendlyError;
    data['result'] = this.result;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}