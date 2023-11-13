class ChangePinResponse {
  final bool? success;
  final String? msg;

  ChangePinResponse({
    this.success,
    this.msg,
  });

  ChangePinResponse.fromJson(Map<String, dynamic> json)
    : success = json['success'] as bool?,
      msg = json['msg'] as String?;

  Map<String, dynamic> toJson() => {
    'success' : success,
    'msg' : msg
  };
}