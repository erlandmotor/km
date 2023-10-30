class CitiesResponse {
  final bool? success;
  final String? rc;
  final Data? data;
  final String? msg;

  CitiesResponse({
    this.success,
    this.rc,
    this.data,
    this.msg,
  });

  CitiesResponse.fromJson(Map<String, dynamic> json)
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
  final List<Cities>? cities;

  Data({
    this.total,
    this.cities,
  });

  Data.fromJson(Map<String, dynamic> json)
    : total = json['total'] as int?,
      cities = (json['cities'] as List?)?.map((dynamic e) => Cities.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'total' : total,
    'cities' : cities?.map((e) => e.toJson()).toList()
  };
}

class Cities {
  final int? cityId;
  final String? cityName;
  final String? type;

  Cities({
    this.cityId,
    this.cityName,
    this.type,
  });

  Cities.fromJson(Map<String, dynamic> json)
    : cityId = json['city_id'] as int?,
      cityName = json['city_name'] as String?,
      type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'city_id' : cityId,
    'city_name' : cityName,
    'type' : type
  };
}