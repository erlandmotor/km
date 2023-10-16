class HistoryTransaksiResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final String? pages;
  final List<HistoryTransaksiData>? data;

  HistoryTransaksiResponse({
    this.success,
    this.count,
    this.countTotal,
    this.pages,
    this.data,
  });

  HistoryTransaksiResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      pages = json['pages'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => HistoryTransaksiData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'pages' : pages,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class HistoryTransaksiData {
  final int? idtransaksi;
  final String? waktu;
  final String? kodetujuan;
  final String? kodeproduk;
  final String? tujuan;
  final String? jenistransaksi;
  final String? sn;
  final int? nominal;
  final int? harga;
  final int? statustransaksi;
  final String? statustext;

  HistoryTransaksiData({
    this.idtransaksi,
    this.waktu,
    this.kodetujuan,
    this.kodeproduk,
    this.tujuan,
    this.jenistransaksi,
    this.sn,
    this.nominal,
    this.harga,
    this.statustransaksi,
    this.statustext,
  });

  HistoryTransaksiData.fromJson(Map<String, dynamic> json)
    : idtransaksi = json['idtransaksi'] as int?,
      waktu = json['waktu'] as String?,
      kodetujuan = json['kodetujuan'] as String?,
      kodeproduk = json['kodeproduk'] as String?,
      tujuan = json['tujuan'] as String?,
      jenistransaksi = json['jenistransaksi'] as String?,
      sn = json['sn'] as String?,
      nominal = json['nominal'] as int?,
      harga = json['harga'] as int?,
      statustransaksi = json['statustransaksi'] as int?,
      statustext = json['statustext'] as String?;

  Map<String, dynamic> toJson() => {
    'idtransaksi' : idtransaksi,
    'waktu' : waktu,
    'kodetujuan' : kodetujuan,
    'kodeproduk' : kodeproduk,
    'tujuan' : tujuan,
    'jenistransaksi' : jenistransaksi,
    'sn' : sn,
    'nominal' : nominal,
    'harga' : harga,
    'statustransaksi' : statustransaksi,
    'statustext' : statustext
  };
}