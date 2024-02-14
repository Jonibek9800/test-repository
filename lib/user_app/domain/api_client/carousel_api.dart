
import '../../../configuration/configuration.dart';
import 'network_client.dart';

class CarouselApi {
  static Future<Map<String, dynamic>> getCarouselImages() async {
    try {
      final response = await NetworkClient.dio.get("/get/sliders");
      if (response.statusCode != 200) {
        return {"error": "I can not get the result"};
      }

      return response.data;
    } catch (err) {
      return {"error": err};
    }
  }

  static String getCarouselPoster({required image}) {
    return "${Configuration.host}/get/carousel/posters/$image";
  }
}
