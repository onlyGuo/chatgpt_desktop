class ApiSetting{
  String accessToken;
  String baseUrl;
  bool isCustom;
  bool bingSearchIsCustom;
  String bingSearchBaseUrl;
  String bingSearchAccessToken;

  ApiSetting({this.accessToken = '', this.baseUrl = '', this.isCustom = false, this.bingSearchIsCustom = false, this.bingSearchBaseUrl = '', this.bingSearchAccessToken = ''});

  // toJson
  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'baseUrl': baseUrl,
    'isCustom': isCustom,
    'bingSearchIsCustom': bingSearchIsCustom,
    'bingSearchBaseUrl': bingSearchBaseUrl,
    'bingSearchAccessToken': bingSearchAccessToken,
  };

  // fromJson
  static ApiSetting fromJson(Map<String, dynamic> json) {
    return ApiSetting(
      accessToken: json['accessToken'],
      baseUrl: json['baseUrl'],
      isCustom: json['isCustom'],
      bingSearchIsCustom: json['bingSearchIsCustom'] ?? false,
      bingSearchBaseUrl: json['bingSearchBaseUrl'] ?? '',
      bingSearchAccessToken: json['bingSearchAccessToken'] ?? '',
    );
  }

}