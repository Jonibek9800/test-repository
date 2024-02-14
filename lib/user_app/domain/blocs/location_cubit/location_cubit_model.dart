import 'package:yandex_mapkit/yandex_mapkit.dart';

class LocationCubitModel {
  double latitude = 38.53575;
  double longitude = 68.77905;
  String? currentLocation;
  List<MapObject> mapObject = [];

  String? address = '';

  YandexMapController? controller;
}