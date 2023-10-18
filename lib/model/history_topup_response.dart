class HistoryTopupResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<HistoryTopupData>? data;

  HistoryTopupResponse({
    this.success,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  HistoryTopupResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => HistoryTopupData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class HistoryTopupData {
  final int? id;
  final String? waktu;
  final String? tanggal;
  final String? keterangan;
  final int? jumlah;

  HistoryTopupData({
    this.id,
    this.waktu,
    this.tanggal,
    this.keterangan,
    this.jumlah,
  });

  HistoryTopupData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      waktu = json['waktu'] as String?,
      tanggal = json['tanggal'] as String?,
      keterangan = json['keterangan'] as String?,
      jumlah = json['jumlah'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'waktu' : waktu,
    'tanggal' : tanggal,
    'keterangan' : keterangan,
    'jumlah' : jumlah
  };
}