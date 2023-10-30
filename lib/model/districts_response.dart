class DistrictsResponse {
  final bool? success;
  final String? rc;
  final Data? data;
  final String? msg;

  DistrictsResponse({
    this.success,
    this.rc,
    this.data,
    this.msg,
  });

  DistrictsResponse.fromJson(Map<String, dynamic> json)
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
  final List<Districts>? districts;

  Data({
    this.total,
    this.districts,
  });

  Data.fromJson(Map<String, dynamic> json)
    : total = json['total'] as int?,
      districts = (json['districts'] as List?)?.map((dynamic e) => Districts.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'total' : total,
    'districts' : districts?.map((e) => e.toJson()).toList()
  };
}

class Districts {
  final int? districtId;
  final String? districtName;

  Districts({
    this.districtId,
    this.districtName,
  });

  Districts.fromJson(Map<String, dynamic> json)
    : districtId = json['district_id'] as int?,
      districtName = json['district_name'] as String?;

  Map<String, dynamic> toJson() => {
    'district_id' : districtId,
    'district_name' : districtName
  };
}