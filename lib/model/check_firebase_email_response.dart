class CheckFirebaseEmailResponse {
  final String? uid;
  final String? email;
  final bool? emailVerified;
  final bool? disabled;
  final Metadata? metadata;
  final String? tokensValidAfterTime;
  final List<ProviderData>? providerData;

  CheckFirebaseEmailResponse({
    this.uid,
    this.email,
    this.emailVerified,
    this.disabled,
    this.metadata,
    this.tokensValidAfterTime,
    this.providerData,
  });

  CheckFirebaseEmailResponse.fromJson(Map<String, dynamic> json)
    : uid = json['uid'] as String?,
      email = json['email'] as String?,
      emailVerified = json['emailVerified'] as bool?,
      disabled = json['disabled'] as bool?,
      metadata = (json['metadata'] as Map<String,dynamic>?) != null ? Metadata.fromJson(json['metadata'] as Map<String,dynamic>) : null,
      tokensValidAfterTime = json['tokensValidAfterTime'] as String?,
      providerData = (json['providerData'] as List?)?.map((dynamic e) => ProviderData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'emailVerified' : emailVerified,
    'disabled' : disabled,
    'metadata' : metadata?.toJson(),
    'tokensValidAfterTime' : tokensValidAfterTime,
    'providerData' : providerData?.map((e) => e.toJson()).toList()
  };
}

class Metadata {
  final String? lastSignInTime;
  final String? creationTime;
  final String? lastRefreshTime;

  Metadata({
    this.lastSignInTime,
    this.creationTime,
    this.lastRefreshTime,
  });

  Metadata.fromJson(Map<String, dynamic> json)
    : lastSignInTime = json['lastSignInTime'] as String?,
      creationTime = json['creationTime'] as String?,
      lastRefreshTime = json['lastRefreshTime'] as String?;

  Map<String, dynamic> toJson() => {
    'lastSignInTime' : lastSignInTime,
    'creationTime' : creationTime,
    'lastRefreshTime' : lastRefreshTime
  };
}

class ProviderData {
  final String? uid;
  final String? email;
  final String? providerId;

  ProviderData({
    this.uid,
    this.email,
    this.providerId,
  });

  ProviderData.fromJson(Map<String, dynamic> json)
    : uid = json['uid'] as String?,
      email = json['email'] as String?,
      providerId = json['providerId'] as String?;

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'providerId' : providerId
  };
}