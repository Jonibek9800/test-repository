import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../resources/resources.dart';
import '../../api_client/location_api.dart';
import 'location_cubit_model.dart';
import 'location_cubit_state.dart';

class LocationCubit extends Cubit<LocationCubitState> {
  LocationCubit()
      : super(InitialLocationState(locationCubitModel: LocationCubitModel()));

  void onCreated(YandexMapController yandexController) {
    final currentState = state.locationCubitModel;
    currentState.controller = yandexController;
    currentState.controller?.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(
                latitude: currentState.latitude,
                longitude: currentState.longitude),
            zoom: 12)),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 1));
    emit(InitialLocationState(locationCubitModel: currentState));
  }

  void zoomIn() async {
    final currentState = state.locationCubitModel;
    var camera = await currentState.controller?.getCameraPosition();
    await currentState.controller?.moveCamera(
        CameraUpdate.zoomTo((camera?.zoom ?? 0) + 0.3),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.7));
    emit(InitialLocationState(locationCubitModel: currentState));
  }

  void zoomOut() async {
    final currentState = state.locationCubitModel;
    var camera = await currentState.controller?.getCameraPosition();
    await currentState.controller?.moveCamera(
        CameraUpdate.zoomTo((camera?.zoom ?? 0) - 0.3),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.7));
    emit(InitialLocationState(locationCubitModel: currentState));
  }

  void currentLocation() async {
    final currentState = state.locationCubitModel;
    final position = await LocationApi.determinePosition();
    currentState.latitude = position.latitude;
    currentState.longitude = position.longitude;
    currentState.controller?.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: Point(
                latitude: currentState.latitude,
                longitude: currentState.longitude),
            zoom: 18)),
        animation:
            const MapAnimation(type: MapAnimationType.smooth, duration: 0.7));
    MapObjectId mapId =
        MapObjectId("map_id${currentState.latitude}${currentState.longitude}");
    currentState.mapObject = [];
    currentState.mapObject.add(PlacemarkMapObject(
        mapId: mapId,
        point: Point(
            latitude: currentState.latitude, longitude: currentState.longitude),
        icon: PlacemarkIcon.single(PlacemarkIconStyle(
            anchor: const Offset(0.5, 1.5),
            image: BitmapDescriptor.fromAssetImage(AppImages.pin),
            scale: 0.500)),
        opacity: 0.5));
    final result = YandexSearch.searchByPoint(
        point: Point(
            latitude: currentState.latitude, longitude: currentState.longitude),
        searchOptions:
            const SearchOptions(searchType: SearchType.geo, geometry: false));
    final searchResult = await result.result;
    currentState.address = searchResult.items?[0].name;
    log("${currentState.address}");

    emit(InitialLocationState(locationCubitModel: currentState));
  }

  void reset () {
    final currentState = state.locationCubitModel;
    currentState.mapObject = [];
    InitialLocationState(locationCubitModel: currentState);
  }
}
