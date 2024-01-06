class ProductResponse {
  final bool? success;
  final List<ProductData>? data;

  ProductResponse({
    this.success,
    this.data,
  });

  ProductResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => ProductData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class ProductData {
  final int? hargajual;
  final int? hargalama;
  final int? komisi;
  final int? idproduk;
  final String? kodeproduk;
  final String? namaproduk;
  final String? namaoperator;
  final String? imgurl;
  final String? keterangan;
  final int? gangguan;
  final int? stokkosong;
  final int? nominal;
  final String? imgurloperator;
  final bool? ispromo;
  final int? poin;

  ProductData({
    this.hargajual,
    this.hargalama,
    this.komisi,
    this.idproduk,
    this.kodeproduk,
    this.namaproduk,
    this.namaoperator,
    this.imgurl,
    this.keterangan,
    this.gangguan,
    this.stokkosong,
    this.nominal,
    this.imgurloperator,
    this.ispromo,
    this.poin,
  });

  ProductData.fromJson(Map<String, dynamic> json)
    : hargajual = json['hargajual'] as int?,
      hargalama = json['hargalama'] as int?,
      komisi = json['komisi'] as int?,
      idproduk = json['idproduk'] as int?,
      kodeproduk = json['kodeproduk'] as String?,
      namaproduk = json['namaproduk'] as String?,
      namaoperator = json['namaoperator'] as String?,
      imgurl = json['imgurl'] as String?,
      keterangan = json['keterangan'] as String?,
      gangguan = json['gangguan'] as int?,
      stokkosong = json['stokkosong'] as int?,
      nominal = json['nominal'] as int?,
      imgurloperator = json['imgurloperator'] as String?,
      ispromo = json['ispromo'] as bool?,
      poin = json['poin'] as int?;

  Map<String, dynamic> toJson() => {
    'hargajual' : hargajual,
    'hargalama' : hargalama,
    'komisi' : komisi,
    'idproduk' : idproduk,
    'kodeproduk' : kodeproduk,
    'namaproduk' : namaproduk,
    'namaoperator' : namaoperator,
    'imgurl' : imgurl,
    'keterangan' : keterangan,
    'gangguan' : gangguan,
    'stokkosong' : stokkosong,
    'nominal' : nominal,
    'imgurloperator' : imgurloperator,
    'ispromo' : ispromo,
    'poin' : poin
  };
}