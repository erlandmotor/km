class GetDownlineResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<DownlineData>? data;

  GetDownlineResponse({
    this.success,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  GetDownlineResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => DownlineData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class DownlineData {
  final String? idreseller;
  final String? namareseller;
  final int? saldo;
  final String? updateAt;
  final String? aktif;
  final int? tambahanhargapribadi;

  DownlineData({
    this.idreseller,
    this.namareseller,
    this.saldo,
    this.updateAt,
    this.aktif,
    this.tambahanhargapribadi,
  });

  DownlineData.fromJson(Map<String, dynamic> json)
    : idreseller = json['idreseller'] as String?,
      namareseller = json['namareseller'] as String?,
      saldo = json['saldo'] as int?,
      updateAt = json['updateAt'] as String?,
      aktif = json['aktif'] as String?,
      tambahanhargapribadi = json['tambahanhargapribadi'] as int?;

  Map<String, dynamic> toJson() => {
    'idreseller' : idreseller,
    'namareseller' : namareseller,
    'saldo' : saldo,
    'updateAt' : updateAt,
    'aktif' : aktif,
    'tambahanhargapribadi' : tambahanhargapribadi
  };
}