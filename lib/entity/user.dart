
import '../user_app/domain/api_client/auth_api_client.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? poster;
  String? phoneNumber;
  String? password;
  String? confirmPassword;
  int? roleOfUserId;
  String? createdAt;
  String? updatedAt;

  User({this.id,
    this.name,
    this.poster,
    this.email,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.roleOfUserId,
    this.createdAt,
    this.updatedAt});

  User.fromJson(Map<String, dynamic>? json) {
    id = json?['id'];
    name = json?['name'];
    poster = json?['poster_path'];
    email = json?['email'];
    phoneNumber = json?['phone_number'];
    password = json?['password'];
    confirmPassword = json?['confirm_password'];
    roleOfUserId = int.tryParse("${json?['role_of_user_id']}");
    createdAt = json?['created_at'];
    updatedAt = json?['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = poster;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['role_of_user_id'] = roleOfUserId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String? getUserImage() {
    final authApiClient = AuthApiClient();
    if (poster != null) {
      return authApiClient.getUserImage(poster);
    } else {
      return null;
    }
  }
}
