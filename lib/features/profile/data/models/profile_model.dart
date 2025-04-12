class ProfileModel {
  String? fullName;
  String? email;
  String? profilePictureUrl;
  int? rating;

  ProfileModel({
    this.fullName,
    this.email,
    this.profilePictureUrl,
    this.rating,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullName'] != null ? json['fullName'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      profilePictureUrl: json['profilePictureUrl'] != null ? json['profilePictureUrl'] as String : null,
      rating: json['rating'] != null ? (json['rating'] is String ? int.tryParse(json['rating'] as String) : json['rating'] as int) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'rating': rating,
    };
  }
}