class PricelistSearchResponse {
  final bool? success;
  final List<Data>? data;

  PricelistSearchResponse({
    this.success,
    this.data,
  });

  PricelistSearchResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? hargajual;
  final int? hargalama;
  final int? komisi;
  final String? kodeproduk;
  final String? namaproduk;
  final String? namaoperator;
  final String? imgurl;
  final String? keterangan;
  final String? jenisproduk;
  final int? gangguan;
  final int? stokkosong;
  final bool? ispromo;

  Data({
    this.hargajual,
    this.hargalama,
    this.komisi,
    this.kodeproduk,
    this.namaproduk,
    this.namaoperator,
    this.imgurl,
    this.keterangan,
    this.jenisproduk,
    this.gangguan,
    this.stokkosong,
    this.ispromo,
  });

  Data.fromJson(Map<String, dynamic> json)
    : hargajual = json['hargajual'] as int?,
      hargalama = json['hargalama'] as int?,
      komisi = json['komisi'] as int?,
      kodeproduk = json['kodeproduk'] as String?,
      namaproduk = json['namaproduk'] as String?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?,
      keterangan = json['keterangan'] as String?,
      jenisproduk = json['jenisproduk'] as String?,
      gangguan = json['gangguan'] as int?,
      stokkosong = json['stokkosong'] as int?,
      ispromo = json['ispromo'] as bool?;

  Map<String, dynamic> toJson() => {
    'hargajual' : hargajual,
    'hargalama' : hargalama,
    'komisi' : komisi,
    'kodeproduk' : kodeproduk,
    'namaproduk' : namaproduk,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl,
    'keterangan' : keterangan,
    'jenisproduk' : jenisproduk,
    'gangguan' : gangguan,
    'stokkosong' : stokkosong,
    'ispromo' : ispromo
  };
}