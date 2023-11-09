class HistoryTransferResponse {
  final bool? success;
  final int? count;
  final int? countTotal;
  final List<HistoryTransferData>? data;

  HistoryTransferResponse({
    this.success,
    this.count,
    this.countTotal,
    this.data,
  });

  HistoryTransferResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      count = json['count'] as int?,
      countTotal = json['count_total'] as int?,
      data = (json['data'] as List?)?.map((dynamic e) => HistoryTransferData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'count' : count,
    'count_total' : countTotal,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class HistoryTransferData {
  final int? id;
  final String? waktu;
  final String? idreseller;
  final String? namareseller;
  final int? jumlah;

  HistoryTransferData({
    this.id,
    this.waktu,
    this.idreseller,
    this.namareseller,
    this.jumlah,
  });

  HistoryTransferData.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      waktu = json['waktu'] as String?,
      idreseller = json['idreseller'] as String?,
      namareseller = json['namareseller'] as String?,
      jumlah = json['jumlah'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'waktu' : waktu,
    'idreseller' : idreseller,
    'namareseller' : namareseller,
    'jumlah' : jumlah
  };
}