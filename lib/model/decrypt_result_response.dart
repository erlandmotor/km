class DecryptResultResponse {
  final DecryptResult? decryptResult;

  DecryptResultResponse({
    this.decryptResult,
  });

  DecryptResultResponse.fromJson(Map<String, dynamic> json)
    : decryptResult = (json['decrypt_result'] as Map<String,dynamic>?) != null ? DecryptResult.fromJson(json['decrypt_result'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'decrypt_result' : decryptResult?.toJson()
  };
}

class DecryptResult {
  final String? type;
  final List<int>? data;

  DecryptResult({
    this.type,
    this.data,
  });

  DecryptResult.fromJson(Map<String, dynamic> json)
    : type = json['type'] as String?,
      data = (json['data'] as List?)?.map((dynamic e) => e as int).toList();

  Map<String, dynamic> toJson() => {
    'type' : type,
    'data' : data
  };
}