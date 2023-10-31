class RegisterResponse {
  final bool? status;
  final String? rc;
  final String? msg;
  final String? idrs;
  final String? namars;

  RegisterResponse({
    this.status,
    this.rc,
    this.msg,
    this.idrs,
    this.namars,
  });

  RegisterResponse.fromJson(Map<String, dynamic> json)
    : status = json['status'] as bool?,
      rc = json['rc'] as String?,
      msg = json['msg'] as String?,
      idrs = json['idrs'] as String?,
      namars = json['namars'] as String?;

  Map<String, dynamic> toJson() => {
    'status' : status,
    'rc' : rc,
    'msg' : msg,
    'idrs' : idrs,
    'namars' : namars
  };
}