class TopupHistoryResponse {
  final bool? success;
  final List<Data>? data;

  TopupHistoryResponse({
    this.success,
    this.data,
  });

  TopupHistoryResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'success' : success,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? idtiketdeposit;
  final String? waktu;
  final String? bank;
  final String? status;
  final int? nominal;

  Data({
    this.idtiketdeposit,
    this.waktu,
    this.bank,
    this.status,
    this.nominal,
  });

  Data.fromJson(Map<String, dynamic> json)
    : idtiketdeposit = json['idtiketdeposit'] as int?,
      waktu = json['waktu'] as String?,
      bank = json['bank'] as String?,
      status = json['status'] as String?,
      nominal = json['nominal'] as int?;

  Map<String, dynamic> toJson() => {
    'idtiketdeposit' : idtiketdeposit,
    'waktu' : waktu,
    'bank' : bank,
    'status' : status,
    'nominal' : nominal
  };
}