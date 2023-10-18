class HistorySaldoResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<HistorySaldoData>? data;

  HistorySaldoResponse({
    this.success,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  HistorySaldoResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => HistorySaldoData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class HistorySaldoData {
  final String? tanggal;
  final String? keterangan;
  final int? jumlah;
  final int? sisasaldo;

  HistorySaldoData({
    this.tanggal,
    this.keterangan,
    this.jumlah,
    this.sisasaldo,
  });

  HistorySaldoData.fromJson(Map<String, dynamic> json)
    : tanggal = json['tanggal'] as String?,
      keterangan = json['keterangan'] as String?,
      jumlah = json['jumlah'] as int?,
      sisasaldo = json['sisasaldo'] as int?;

  Map<String, dynamic> toJson() => {
    'tanggal' : tanggal,
    'keterangan' : keterangan,
    'jumlah' : jumlah,
    'sisasaldo' : sisasaldo
  };
}