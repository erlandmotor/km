class KomisiHistoryResponse {
  final bool? success;
  final int? komisi;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<KomisiHistoryData>? data;

  KomisiHistoryResponse({
    this.success,
    this.komisi,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  KomisiHistoryResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      komisi = json['komisi'] as int?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => KomisiHistoryData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'komisi' : komisi,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class KomisiHistoryData {
  final int? id;
  final String? waktu;
  final String? keterangan;
  final int? jumlah;

  KomisiHistoryData({
    this.id,
    this.waktu,
    this.keterangan,
    this.jumlah,
  });

  KomisiHistoryData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      waktu = json['waktu'] as String?,
      keterangan = json['keterangan'] as String?,
      jumlah = json['jumlah'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'waktu' : waktu,
    'keterangan' : keterangan,
    'jumlah' : jumlah
  };
}