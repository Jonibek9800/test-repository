
import '../user_app/domain/api_client/category_api.dart';

class Category {
  int? id;
  String? posterPath;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category(
      {this.id, this.posterPath, this.title, this.createdAt, this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    posterPath = json['poster_path'];
    title = json['title'];
    createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null;
    updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = posterPath;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String getCategoryImage () {
    return CategoryApiClient().getCategoryImage(posterPath);
  }
}