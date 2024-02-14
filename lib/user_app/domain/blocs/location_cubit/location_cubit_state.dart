import 'location_cubit_model.dart';

class LocationCubitState {
  LocationCubitModel locationCubitModel;

  LocationCubitState({required this.locationCubitModel});
}

class InitialLocationState extends LocationCubitState {
  InitialLocationState({required LocationCubitModel locationCubitModel})
      : super(locationCubitModel: locationCubitModel);
}
