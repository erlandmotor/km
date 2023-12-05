class OtpBackofficeResponse {
  final String? message;
  final String? hp;

  OtpBackofficeResponse({
    this.message,
    this.hp
  });

  OtpBackofficeResponse.fromJson(Map<String, dynamic> json)
    : message = json['message'] as String?,
      hp = json['hp'] as String?;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'hp' : hp
  };
}