class RewardExchangeResponse {
  final bool? success;
  final String? rc;
  final Data? data;
  final String? msg;

  RewardExchangeResponse({
    this.success,
    this.rc,
    this.data,
    this.msg,
  });

  RewardExchangeResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      rc = json['rc'] as String?,
      data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'rc' : rc,
    'data' : data?.toJson(),
    'msg' : msg
  };
}

class Data {
  final int? total;
  final List<Histories>? histories;

  Data({
    this.total,
    this.histories,
  });

  Data.fromJson(Map<String, dynamic> json)
    : total = json['total'] as int?,
      histories = (json['histories'] as List?)?.map((dynamic e) => Histories.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'total' : total,
    'histories' : histories?.map((e) => e.toJson()).toList()
  };
}

class Histories {
  final String? waktu;
  final String? hadiah;
  final int? poin;
  final String? imgurl;
  final int? status;
  final String? statustext;

  Histories({
    this.waktu,
    this.hadiah,
    this.poin,
    this.imgurl,
    this.status,
    this.statustext,
  });

  Histories.fromJson(Map<String, dynamic> json)
    : waktu = json['waktu'] as String?,
      hadiah = json['hadiah'] as String?,
      poin = json['poin'] as int?,
      imgurl = json['imgurl'] as String?,
      status = json['status'] as int?,
      statustext = json['statustext'] as String?;

  Map<String, dynamic> toJson() => {
    'waktu' : waktu,
    'hadiah' : hadiah,
    'poin' : poin,
    'imgurl' : imgurl,
    'status' : status,
    'statustext' : statustext
  };
}