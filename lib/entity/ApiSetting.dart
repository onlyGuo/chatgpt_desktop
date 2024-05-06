class ApiSetting{
  String accessToken;
  String baseUrl;
  bool isCustom;
  bool bingSearchIsCustom;

  ApiSetting({this.accessToken = '', this.baseUrl = '', this.isCustom = false, this.bingSearchIsCustom = false});

  // toJson
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'baseUrl': baseUrl,
    'isCustom': isCustom,
    'bingSearchIsCustom': bingSearchIsCustom,
  };

  // fromJson
  static ApiSetting fromJson(Map<String, dynamic> json) {
    return ApiSetting(
      accessToken: json['accessToken'],
      baseUrl: json['baseUrl'],
      isCustom: json['isCustom'],
      bingSearchIsCustom: json['bingSearchIsCustom'] ?? false,
    );
  }

}