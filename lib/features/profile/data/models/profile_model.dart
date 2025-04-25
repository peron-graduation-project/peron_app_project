class ProfileModel {
  String? fullName;
  String? email;
  String? profilePictureUrl;
  String? phoneNumber;

  ProfileModel({
    this.fullName,
    this.email,
    this.profilePictureUrl,
    this.phoneNumber,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'phoneNumber': phoneNumber,
    };
  }

  factory ProfileModel.empty() {
    return ProfileModel(
      fullName: null,
      email: null,
      profilePictureUrl: null,
      phoneNumber: null,
    );
  }
}
