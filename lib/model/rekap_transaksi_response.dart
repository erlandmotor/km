class RekapTransaksiResponse {
  final bool? success;
  final List<RekapTransaksiData>? data;

  RekapTransaksiResponse({
    this.success,
    this.data,
  });

  RekapTransaksiResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => RekapTransaksiData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class RekapTransaksiData {
  final String? kodeproduk;
  final String? namaproduk;
  final int? jumlah;
  final int? total;
  final String? imageproduk;
  final String? imgurl;

  RekapTransaksiData({
    this.kodeproduk,
    this.namaproduk,
    this.jumlah,
    this.total,
    this.imageproduk,
    this.imgurl,
  });

  RekapTransaksiData.fromJson(Map<String, dynamic> json)
    : kodeproduk = json['kodeproduk'] as String?,
      namaproduk = json['namaproduk'] as String?,
      jumlah = json['jumlah'] as int?,
      total = json['total'] as int?,
      imageproduk = json['imageproduk'] as String?,
      imgurl = json['imgurl'] as String?;

  Map<String, dynamic> toJson() => {
    'kodeproduk' : kodeproduk,
    'namaproduk' : namaproduk,
    'jumlah' : jumlah,
    'total' : total,
    'imageproduk' : imageproduk,
    'imgurl' : imgurl
  };
}