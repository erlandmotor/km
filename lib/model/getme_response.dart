class GetMeResponse {
  final bool? success;
  final Data? data;

  GetMeResponse({
    this.success,
    this.data,
  });

  GetMeResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.toJson()
  };
}

class Data {
  final String? idreseller;
  final String? nama;
  final int? saldo;
  final int? poin;
  final int? komisi;
  final int? jmldownline;

  Data({
    this.idreseller,
    this.nama,
    this.saldo,
    this.poin,
    this.komisi,
    this.jmldownline,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idreseller = json['idreseller'] as String?,
      nama = json['nama'] as String?,
      saldo = json['saldo'] as int?,
      poin = json['poin'] as int?,
      komisi = json['komisi'] as int?,
      jmldownline = json['jmldownline'] as int?;

  Map<String, dynamic> toJson() => {
    'idreseller' : idreseller,
    'nama' : nama,
    'saldo' : saldo,
    'poin' : poin,
    'komisi' : komisi,
    'jmldownline' : jmldownline
  };
}