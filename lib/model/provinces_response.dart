class ProvincesResponse {
  final bool? success;
  final String? rc;
  final Data? data;
  final String? msg;

  ProvincesResponse({
    this.success,
    this.rc,
    this.data,
    this.msg,
  });

  ProvincesResponse.fromJson(Map<String, dynamic> json)
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
  final List<Provinces>? provinces;

  Data({
    this.total,
    this.provinces,
  });

  Data.fromJson(Map<String, dynamic> json)
    : total = json['total'] as int?,
      provinces = (json['provinces'] as List?)?.map((dynamic e) => Provinces.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'total' : total,
    'provinces' : provinces?.map((e) => e.toJson()).toList()
  };
}

class Provinces {
  final int? provinceId;
  final String? provinceName;

  Provinces({
    this.provinceId,
    this.provinceName,
  });

  Provinces.fromJson(Map<String, dynamic> json)
    : provinceId = json['province_id'] as int?,
      provinceName = json['province_name'] as String?;

  Map<String, dynamic> toJson() => {
    'province_id' : provinceId,
    'province_name' : provinceName
  };
}