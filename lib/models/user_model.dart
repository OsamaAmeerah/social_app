class UserModel {
   String? email;
   String? name;
   String? phone;
   String? image;
   String? cover;
   String? bio;
   String? uId;
   bool? isEmailVerified;

  UserModel({
   this.email,
   this.name,
   this.phone,
   this.image,
   this.cover,
   this.bio,
   this.uId,
    this. isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic>? json)
  {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
  uId = json['uId'];
  image = json['image'];
  cover = json['cover'];
  bio = json['bio'];
  isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}