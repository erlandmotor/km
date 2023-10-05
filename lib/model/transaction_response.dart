class TransactionResponse {
  final bool? success;
  final String? produk;
  final String? tujuan;
  final String? reffid;
  final String? rc;
  final String? msg;

  TransactionResponse({
    this.success,
    this.produk,
    this.tujuan,
    this.reffid,
    this.rc,
    this.msg,
  });

  TransactionResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      produk = json['produk'] as String?,
      tujuan = json['tujuan'] as String?,
      reffid = json['reffid'] as String?,
      rc = json['rc'] as String?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'produk' : produk,
    'tujuan' : tujuan,
    'reffid' : reffid,
    'rc' : rc,
    'msg' : msg
  };
}