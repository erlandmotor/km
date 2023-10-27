class RedeemKomisiResponse {
  final bool? success;
  final String? komisi;
  final String? msg;

  RedeemKomisiResponse({
    this.success,
    this.komisi,
    this.msg,
  });

  RedeemKomisiResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      komisi = json['komisi'] as String?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'komisi' : komisi,
    'msg' : msg
  };
}