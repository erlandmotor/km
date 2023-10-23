class RewardResponse {
  final bool? success;
  final List<Data>? data;

  RewardResponse({
    this.success,
    this.data,
  });

  RewardResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? idhadiahpoin;
  final int? idreward;
  final int? nomor;
  final int? jumlahpoin;
  final String? hadiah;
  final String? imgurl;
  final int? jenishadiah;

  Data({
    this.idhadiahpoin,
    this.idreward,
    this.nomor,
    this.jumlahpoin,
    this.hadiah,
    this.imgurl,
    this.jenishadiah,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idhadiahpoin = json['idhadiahpoin'] as int?,
      idreward = json['idreward'] as int?,
      nomor = json['nomor'] as int?,
      jumlahpoin = json['jumlahpoin'] as int?,
      hadiah = json['hadiah'] as String?,
      imgurl = json['imgurl'] as String?,
      jenishadiah = json['jenishadiah'] as int?;

  Map<String, dynamic> toJson() => {
    'idhadiahpoin' : idhadiahpoin,
    'idreward' : idreward,
    'nomor' : nomor,
    'jumlahpoin' : jumlahpoin,
    'hadiah' : hadiah,
    'imgurl' : imgurl,
    'jenishadiah' : jenishadiah
  };
}