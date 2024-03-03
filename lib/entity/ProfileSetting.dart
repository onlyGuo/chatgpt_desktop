class ProfileSetting {
  String nicker;
  String avatar;
  ProfileSetting({
    this.nicker = 'You',
    this.avatar = '',
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'nicker': nicker,
    'avatar': avatar,
  };

  // fromJson

  static ProfileSetting fromJson(Map<String, dynamic> json) {
    return ProfileSetting(
      nicker: json['nicker'],
      avatar: json['avatar'],
    );
  }
}