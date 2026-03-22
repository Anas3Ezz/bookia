class ProfileModel {
  ProfileData? data;
  String? message;
  int? status;

  ProfileModel({this.data, this.message, this.status});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class ProfileData {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  String? phone;
  bool? emailVerified;
  String? image;

  ProfileData({
    this.id,
    this.name,
    this.email,
    this.address,
    this.city,
    this.phone,
    this.emailVerified,
    this.image,
  });

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    city = json['city'];
    phone = json['phone'];
    emailVerified = json['email_verified'];
    image = json['image'];
  }
}
