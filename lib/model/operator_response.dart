class OperatorResponse {
  final bool? success;
  final List<Data>? data;

  OperatorResponse({
    this.success,
    this.data,
  });

  OperatorResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? idoperator;
  final String? namaoperator;
  final String? imgurl;

  Data({
    this.idoperator,
    this.namaoperator,
    this.imgurl,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idoperator = json['idoperator'] as int?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?;

  Map<String, dynamic> toJson() => {
    'idoperator' : idoperator,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl
  };
}