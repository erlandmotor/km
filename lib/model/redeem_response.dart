class RedeemResponse {
  final bool? success;
  final String? rc;
  final String? msg;

  RedeemResponse({
    this.success,
    this.rc,
    this.msg,
  });

  RedeemResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      rc = json['rc'] as String?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'rc' : rc,
    'msg' : msg
  };
}