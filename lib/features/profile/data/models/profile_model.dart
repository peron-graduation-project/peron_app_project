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
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      rating: _parseRating(json['rating']),
    );
  }

  static int? _parseRating(dynamic rating) {
    if (rating == null) return null;
    if (rating is String) {
      return int.tryParse(rating);
    } else if (rating is int) {
      return rating;
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'rating': rating,
    };
  }

  factory ProfileModel.empty() {
    return ProfileModel(
      fullName: null,
      email: null,
      profilePictureUrl: null,
      rating: null,
    );
  }
}
