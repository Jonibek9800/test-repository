
import '../user_app/domain/api_client/carousel_api.dart';

class Slider {
  int? id;
  String? poster;
  String? startDate;
  String? expirationDate;
  String? createdAt;
  String? updatedAt;

  Slider({
    this.id,
    required this.poster,
    required this.startDate,
    required this.expirationDate,
    this.createdAt,
    this.updatedAt,
  });

  Slider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poster = json['poster_path'];
    startDate = json['start_date'];
    expirationDate = json['expiration_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['poster_path'] = poster;
    data['start_date'] = startDate;
    data['expiration_date'] = expirationDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  String getPoster() {
    return CarouselApi.getCarouselPoster(image: poster);
  }
}
