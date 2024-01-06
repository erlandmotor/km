class SettingApplikasiResponse {
  final int? id;
  final String? kategori;
  final String? logoMain;
  final String? logoLight;
  final String? loginImage;
  final String? phoneImage;
  final String? otpImage;
  final String? pinImage;
  final String? mainColor1;
  final String? mainColor2;
  final String? mainColor3;
  final String? secondaryColor;
  final String? lightColor;
  final String? successColor;
  final String? infoColor;
  final String? surfaceColor;
  final String? indicatorColor;
  final String? errorColor;
  final String? textColor;
  final String? lightTextColor;
  final String? createdAt;
  final String? updatedAt;

  SettingApplikasiResponse({
    this.id,
    this.kategori,
    this.logoMain,
    this.logoLight,
    this.loginImage,
    this.phoneImage,
    this.otpImage,
    this.pinImage,
    this.mainColor1,
    this.mainColor2,
    this.mainColor3,
    this.secondaryColor,
    this.lightColor,
    this.successColor,
    this.infoColor,
    this.surfaceColor,
    this.indicatorColor,
    this.errorColor,
    this.textColor,
    this.lightTextColor,
    this.createdAt,
    this.updatedAt,
  });

  SettingApplikasiResponse.fromJson(Map<String, dynamic> json)
    : id = json['id'] as int?,
      kategori = json['kategori'] as String?,
      logoMain = json['logo_main'] as String?,
      logoLight = json['logo_light'] as String?,
      loginImage = json['login_image'] as String?,
      phoneImage = json['phone_image'] as String?,
      otpImage = json['otp_image'] as String?,
      pinImage = json['pin_image'] as String?,
      mainColor1 = json['main_color1'] as String?,
      mainColor2 = json['main_color2'] as String?,
      mainColor3 = json['main_color3'] as String?,
      secondaryColor = json['secondary_color'] as String?,
      lightColor = json['light_color'] as String?,
      successColor = json['success_color'] as String?,
      infoColor = json['info_color'] as String?,
      surfaceColor = json['surface_color'] as String?,
      indicatorColor = json['indicator_color'] as String?,
      errorColor = json['error_color'] as String?,
      textColor = json['text_color'] as String?,
      lightTextColor = json['light_text_color'] as String?,
      createdAt = json['created_at'] as String?,
      updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'kategori' : kategori,
    'logo_main' : logoMain,
    'logo_light' : logoLight,
    'login_image' : loginImage,
    'phone_image' : phoneImage,
    'otp_image' : otpImage,
    'pin_image' : pinImage,
    'main_color1' : mainColor1,
    'main_color2' : mainColor2,
    'main_color3' : mainColor3,
    'secondary_color' : secondaryColor,
    'light_color' : lightColor,
    'success_color' : successColor,
    'info_color' : infoColor,
    'surface_color' : surfaceColor,
    'indicator_color' : indicatorColor,
    'error_color' : errorColor,
    'text_color' : textColor,
    'light_text_color' : lightTextColor,
    'created_at' : createdAt,
    'updated_at' : updatedAt
  };
}